part of stagexl_rockdot;

@retain
class ScreenTransitionPrepareCommand extends AbstractScreenCommand {
  ScreenDisplaylistTransitionPrepareVO _vo;

  @override void execute([XLSignal event = null]) {
    super.execute(event);

    String APPLY_EFFECT = ScreenDisplaylistEvents.TRANSITION_RUN;

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

      // provide intarget with stage
      if (_vo.inTarget.stage == null) {
        switch (_vo.transitionType) {
          case ScreenConstants.TRANSITION_NORMAL_TO_MODAL:
          case ScreenConstants.TRANSITION_MODAL_TO_MODAL:
            // add intarget to layer stack
            _uiService.layer.addChild(_vo.inTarget as DisplayObject);
            break;
          default:
            _uiService.content.addChild(_vo.inTarget as DisplayObject);
            break;
        }
      }

      compositeCommand.addCommandEvent(new XLSignal(ScreenEvents.RESIZE, _vo.inTarget), _context);
      compositeCommand.addCommandEvent(new XLSignal(ScreenDisplaylistEvents.SCREEN_INIT, _vo.inTarget), _context);
    }

    ISpriteComponent layer;

    switch (_vo.transitionType) {
      case ScreenConstants.TRANSITION_NONE_TO_NORMAL:
        compositeCommand.addCommandEvent(new XLSignal(APPLY_EFFECT, new ScreenDisplaylistTransitionApplyVO(_vo.effect, ScreenConstants.EFFECT_IN, _vo.inTarget, _vo.effect.duration)), _context);
        break;
      case ScreenConstants.TRANSITION_NORMAL_TO_NORMAL:
        compositeCommand.addCommandEvent(new XLSignal(ScreenDisplaylistEvents.DISAPPEAR, new ScreenDisplaylistAppearDisappearVO(_vo.outTarget, 0, false)), _context);
        compositeCommand.addCommandEvent(new XLSignal(APPLY_EFFECT, new ScreenDisplaylistTransitionApplyVO(_vo.effect, _vo.effect.type, _vo.outTarget, _vo.effect.duration, _vo.inTarget)), _context);
        break;
      case ScreenConstants.TRANSITION_NORMAL_TO_MODAL:
        _uiService.blur();
        compositeCommand.addCommandEvent(new XLSignal(APPLY_EFFECT, new ScreenDisplaylistTransitionApplyVO(_vo.effect, ScreenConstants.EFFECT_IN, _vo.inTarget, _vo.effect.duration)), _context);
        break;
      case ScreenConstants.TRANSITION_MODAL_TO_MODAL:
        _vo.outTarget = _uiService.layer.getChildAt(0) as ISpriteComponent;
        compositeCommand.addCommandEvent(new XLSignal(ScreenDisplaylistEvents.DISAPPEAR, new ScreenDisplaylistAppearDisappearVO(_vo.outTarget, 0, false)), _context);
        compositeCommand.addCommandEvent(new XLSignal(APPLY_EFFECT, new ScreenDisplaylistTransitionApplyVO(_vo.effect, _vo.effect.type, _vo.outTarget, _vo.effect.duration, _vo.inTarget)), _context);
        break;
      case ScreenConstants.TRANSITION_MODAL_BACK:
        // unblur content
        _uiService.unblur();
        compositeCommand.addCommandEvent(new XLSignal(APPLY_EFFECT, new ScreenDisplaylistTransitionApplyVO(_vo.effect, ScreenConstants.EFFECT_OUT, _uiService.layer.getChildAt(_uiService.layer.numChildren - 1) as ISpriteComponent, _vo.effect.duration), _destroyLayer), _context);
        break;
      case ScreenConstants.TRANSITION_MODAL_TO_NORMAL:
        // unblur content
        _uiService.unblur();
        layer = _uiService.layer.getChildAt(0) as ISpriteComponent;
        compositeCommand.addCommandEvent(new XLSignal(ScreenDisplaylistEvents.DISAPPEAR, new ScreenDisplaylistAppearDisappearVO(layer, 0, false)), _context);
        IEffect effect = _context.getObject("transition.default.modal");
        compositeCommand.addCommandEvent(new XLSignal(ScreenDisplaylistEvents.APPLY_EFFECT_OUT, new ScreenDisplaylistEffectApplyVO(effect, layer, _vo.effect.duration), _destroyLayer), _context);
        compositeCommand.addCommandEvent(new XLSignal(APPLY_EFFECT, new ScreenDisplaylistTransitionApplyVO(_vo.effect, _vo.effect.type, _vo.outTarget, _vo.effect.duration, _vo.inTarget)), _context);
        break;
    }

    compositeCommand.addCommandEvent(new XLSignal(ScreenDisplaylistEvents.APPEAR, new ScreenDisplaylistAppearDisappearVO(_vo.inTarget, _vo.effect.duration)), _context);

    /* add sequence listeners */
    compositeCommand.addCompleteListener(_onSequenceComplete);
    compositeCommand.addErrorListener(_handleError);
    compositeCommand.execute();

    _stateModel.compositeTransitionCommand = compositeCommand;

  }

  void _destroyLayer([dynamic result = null]) {
    if (_uiService.layer.numChildren > 0) {
      ISpriteComponent layer = _uiService.layer.getChildAt(0) as ISpriteComponent;
      layer.destroy();
      layer = null;
    }
  }

  void _onSequenceComplete([OperationEvent event = null]) {
    if (_vo.effect != null) {
      _vo.effect.destroy();
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
