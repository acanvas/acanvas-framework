part of stagexl_rockdot.screen;


//@retain
class ScreenTransitionRunCommand extends AbstractScreenCommand {

  ScreenDisplaylistTransitionApplyVO _vo;
  CompositeCommandWithEvent _compositeCommand;

  @override void execute([RdSignal event = null]) {
    super.execute(event);
    _compositeCommand = new CompositeCommandWithEvent(CompositeCommandKind.SEQUENCE);
    _vo = event.data;
    _applyEffect(_vo.transitionType, _vo.targetPrimary, _vo.duration, dispatchCompleteEvent, _vo.targetSecondary);

  }

  void _applyEffect(String effectType, Sprite target, num duration, Function callback, [Sprite nextTarget = null]) {

    if (duration == null) duration = _vo.effect.duration;

    int maxdepthTarget = 0;
    int maxdepthNextTarget = 0;
    if (_vo.effect.applyRecursively) {
      maxdepthTarget = _getDepth(target, 0);
      if (nextTarget != null) {
        maxdepthNextTarget = _getDepth(nextTarget, 0);
      }
    }

    //some day, someone will explain this to you.
    switch (effectType) {
      case ScreenConstants.EFFECT_IN:
        if (_vo.effect.applyRecursively) {
          _addInEffectRecursively(target, 0, duration, duration, maxdepthTarget);
        }
        _compositeCommand.addCommandEvent(new RdSignal(ScreenDisplaylistEvents.APPLY_EFFECT_IN, new ScreenDisplaylistEffectApplyVO(_vo.effect, target, duration)), applicationContext);
        break;
      case ScreenConstants.EFFECT_OUT:
        if (_vo.effect.applyRecursively) {
          _addOutEffectRecursively(target, 0, duration, 0, maxdepthTarget);
        }
        _compositeCommand.addCommandEvent(new RdSignal(ScreenDisplaylistEvents.APPLY_EFFECT_OUT, new ScreenDisplaylistEffectApplyVO(_vo.effect, target, duration)), applicationContext);
        break;
      case ScreenConstants.TRANSITION_SEQUENTIAL:

        _compositeCommand.addCommandEvent(new RdSignal(ScreenDisplaylistEvents.APPLY_EFFECT_OUT, new ScreenDisplaylistEffectApplyVO(_vo.effect, target, duration)), applicationContext);

        if (_vo.effect.applyRecursively) {
          _addOutEffectRecursively(target, 0, duration, 0, maxdepthTarget);
          _addInEffectRecursively(nextTarget, 0, duration, (maxdepthNextTarget * duration) + 2 * duration, maxdepthNextTarget);
        }
        _compositeCommand.addCommandEvent(new RdSignal(ScreenDisplaylistEvents.APPLY_EFFECT_IN, new ScreenDisplaylistEffectApplyVO(_vo.effect, nextTarget, duration)), applicationContext);

        break;
      case ScreenConstants.TRANSITION_PARALLEL:
        _compositeCommand.kind = CompositeCommandKind.PARALLEL;

        _compositeCommand.addCommandEvent(new RdSignal(ScreenDisplaylistEvents.APPLY_EFFECT_OUT, new ScreenDisplaylistEffectApplyVO(_vo.effect, target, duration)), applicationContext);

        if (_vo.effect.applyRecursively) {
          _addOutEffectRecursively(target, 0, duration, 0, maxdepthTarget);
          _addInEffectRecursively(nextTarget, 0, duration, 0, maxdepthNextTarget);
        }
        _compositeCommand.addCommandEvent(new RdSignal(ScreenDisplaylistEvents.APPLY_EFFECT_IN, new ScreenDisplaylistEffectApplyVO(_vo.effect, nextTarget, duration)), applicationContext);

        break;
    }


    /* add sequence listeners */
    _compositeCommand.addCompleteListener(dispatchCompleteEvent);
    _compositeCommand.addErrorListener(dispatchErrorEvent);
    _compositeCommand.execute();

    _stateModel.compositeEffectCommand = _compositeCommand;
  }

  void _addInEffectRecursively(Sprite parent, int depth, num duration, num delay, int maxdepth) {
    parent.children.where((c) => c is Sprite).forEach((child) {
      _compositeCommand.addCommandEvent(new RdSignal(ScreenDisplaylistEvents.APPLY_EFFECT_IN, new ScreenDisplaylistEffectApplyVO(_vo.effect, child, duration)), applicationContext);
      _addInEffectRecursively(child, depth + 1, duration, delay, maxdepth);
    });
  }

  void _addOutEffectRecursively(Sprite parent, int depth, num duration, num delay, int maxdepth) {
    if (depth > maxdepth) return;
    parent.children.where((c) => c is Sprite).forEach((child) {
      _compositeCommand.addCommandEvent(new RdSignal(ScreenDisplaylistEvents.APPLY_EFFECT_OUT, new ScreenDisplaylistEffectApplyVO(_vo.effect, child, duration)), applicationContext);
      _addOutEffectRecursively(child, depth + 1, duration, delay, maxdepth);
    });
  }

  int _getDepth(Sprite vcs, int depth) {
    int maxd = depth;
    vcs.children.where((c) => c is Sprite).forEach((child) {
      maxd = math.max(_getDepth(child as DisplayObjectContainer, depth + 1), maxd);
    });
    return maxd;
  }

  @override bool dispatchCompleteEvent([dynamic result = null]) {

    if (_vo.transitionType != ScreenConstants.EFFECT_IN) {
      _vo.targetPrimary.dispose();
      _vo.targetPrimary = null;
      _vo = null;
    } else {
      if (_vo.targetPrimary.enabled != true) {
        _vo.targetPrimary.enabled = true;
      }
    }

    return super.dispatchCompleteEvent(result);
  }
}
