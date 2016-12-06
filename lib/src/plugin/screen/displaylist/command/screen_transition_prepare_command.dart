part of rockdot_framework.screen;

//@retain
class ScreenTransitionPrepareCommand extends AbstractScreenCommand {
  ScreenDisplaylistTransitionPrepareVO _vo;

  @override void execute([RdSignal event = null]) {
    super.execute(event);

    _uiService.lock();
    _vo = event.data;

    CompositeCommandWithEvent compositeCommand = new CompositeCommandWithEvent(CompositeCommandKind.SEQUENCE);

    // check if the transition requires an extra root sprite
    if (_vo.effect != null && _vo.effect.useSprite()) {
      switch (_vo.transitionType) {
        case ScreenConstants.TRANSITION_NORMAL_TO_MODAL:
        case ScreenConstants.TRANSITION_MODAL_TO_MODAL:
          _uiService.layer.addChild(_vo.effect.sprite);
          break;
        default:
          _uiService.content.addChild(_vo.effect.sprite);
          break;
      }
    }

    if (_vo.outTarget != null && _vo.outTarget.enabled) {
      _vo.outTarget.enabled = false;
    }

    if (_vo.inTarget != null && _vo.transitionType != ScreenConstants.TRANSITION_MODAL_BACK) {
      _vo.inTarget.alpha = _vo.initialAlpha;
      _vo.inTarget.inheritInit = false;

      // provide intarget with stage
      if (_vo.inTarget.stage == null) {
        switch (_vo.transitionType) {
          case ScreenConstants.TRANSITION_NORMAL_TO_MODAL:
          case ScreenConstants.TRANSITION_MODAL_TO_MODAL:
          // add intarget to layer stack
            _uiService.layer.addChild(_vo.inTarget);
            break;
          default:
            _uiService.content.addChild(_vo.inTarget);
            break;
        }
      }

      if(_vo.inTarget.spanWidth == 0 || _vo.inTarget.spanHeight == 0){
        compositeCommand.addCommandEvent(new RdSignal(ScreenEvents.RESIZE, _vo.inTarget), applicationContext);
      }
      compositeCommand.addCommandEvent(new RdSignal(ScreenDisplaylistEvents.SCREEN_LOAD, _vo.inTarget), applicationContext);
      compositeCommand.addCommandEvent(new RdSignal(ScreenDisplaylistEvents.SCREEN_INIT, _vo.inTarget), applicationContext);
    }

    LifecycleSprite layer;
    String TRANSITION_APPLY = ScreenDisplaylistEvents.TRANSITION_RUN;

    switch (_vo.transitionType) {
      case ScreenConstants.TRANSITION_NONE_TO_NORMAL:
        compositeCommand.addCommandEvent(new RdSignal(TRANSITION_APPLY, new ScreenDisplaylistTransitionApplyVO(_vo.effect, ScreenConstants.EFFECT_IN, _vo.inTarget, _vo.effect.duration)), applicationContext);
        break;
      case ScreenConstants.TRANSITION_NORMAL_TO_NORMAL:
        compositeCommand.addCommandEvent(new RdSignal(ScreenDisplaylistEvents.DISAPPEAR, new ScreenDisplaylistAppearDisappearVO(_vo.outTarget, 0.0, false)), applicationContext);
        compositeCommand.addCommandEvent(new RdSignal(TRANSITION_APPLY, new ScreenDisplaylistTransitionApplyVO(_vo.effect, _vo.effect.type, _vo.outTarget, _vo.effect.duration, _vo.inTarget)), applicationContext);
        break;
      case ScreenConstants.TRANSITION_NORMAL_TO_MODAL:
        _uiService.blur();
        compositeCommand.addCommandEvent(new RdSignal(TRANSITION_APPLY, new ScreenDisplaylistTransitionApplyVO(_vo.effect, ScreenConstants.EFFECT_IN, _vo.inTarget, _vo.effect.duration)), applicationContext);
        break;
      case ScreenConstants.TRANSITION_MODAL_TO_MODAL:
        _vo.outTarget = _uiService.layer.getChildAt(0) as LifecycleSprite;
        compositeCommand.addCommandEvent(new RdSignal(ScreenDisplaylistEvents.DISAPPEAR, new ScreenDisplaylistAppearDisappearVO(_vo.outTarget, 0.0, false)), applicationContext);
        compositeCommand.addCommandEvent(new RdSignal(TRANSITION_APPLY, new ScreenDisplaylistTransitionApplyVO(_vo.effect, _vo.effect.type, _vo.outTarget, _vo.effect.duration, _vo.inTarget)), applicationContext);
        break;
      case ScreenConstants.TRANSITION_MODAL_BACK:
      // unblur content
        _uiService.unblur();
        compositeCommand.addCommandEvent(new RdSignal(TRANSITION_APPLY, new ScreenDisplaylistTransitionApplyVO(_vo.effect, ScreenConstants.EFFECT_OUT, _uiService.layer.getChildAt(_uiService.layer.numChildren - 1) as LifecycleSprite, _vo.effect.duration), _destroyLayer), applicationContext);
        break;
      case ScreenConstants.TRANSITION_MODAL_TO_NORMAL:
      // unblur content
        _uiService.unblur();
        layer = _uiService.layer.getChildAt(0) as LifecycleSprite;
        compositeCommand.addCommandEvent(new RdSignal(ScreenDisplaylistEvents.DISAPPEAR, new ScreenDisplaylistAppearDisappearVO(layer, 0.0, false)), applicationContext);
        IEffect effect = applicationContext.getObject("transition.default.modal");
        compositeCommand.addCommandEvent(new RdSignal(ScreenDisplaylistEvents.APPLY_EFFECT_OUT, new ScreenDisplaylistEffectApplyVO(effect, layer, _vo.effect.duration), _destroyLayer), applicationContext);
        compositeCommand.addCommandEvent(new RdSignal(TRANSITION_APPLY, new ScreenDisplaylistTransitionApplyVO(_vo.effect, _vo.effect.type, _vo.outTarget, _vo.effect.duration, _vo.inTarget)), applicationContext);
        break;
    }

    compositeCommand.addCommandEvent(new RdSignal(ScreenDisplaylistEvents.APPEAR, new ScreenDisplaylistAppearDisappearVO(_vo.inTarget, _vo.effect.duration)), applicationContext);

    /* add sequence listeners */
    compositeCommand.addCompleteListener(_onSequenceComplete);
    compositeCommand.addErrorListener(dispatchErrorEvent);
    compositeCommand.execute();

    _stateModel.compositeTransitionCommand = compositeCommand;

  }

  void _destroyLayer([dynamic result = null]) {
    if (_uiService.layer.numChildren > 0) {
      LifecycleSprite layer = _uiService.layer.getChildAt(0) as LifecycleSprite;
      layer.dispose();
      layer = null;
    }
  }

  void _onSequenceComplete([OperationEvent event = null]) {
    if (_vo.effect != null) {
      _vo.effect.dispose();
    }

    if (_vo.inTarget != null) {
      if (_vo.inTarget.enabled != true) {
        _vo.inTarget.enabled = true;
      }
    }
    _vo = null;
    _uiService.unlock();
    _stateModel.compositeTransitionCommand = null;
    dispatchCompleteEvent();
  }
}
