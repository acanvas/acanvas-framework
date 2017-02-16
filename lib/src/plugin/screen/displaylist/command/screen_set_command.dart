part of rockdot_framework.screen;

/**
 * @author Nils Doehring (nilsdoehring(gmail as at).com)
 */
//@retain
class ScreenSetCommand extends AbstractStateCommand {
  StateVO _currentVO;
  StateVO _nextVO;
  MLifecycle _currentStateElement;
  MLifecycle _nextStateElement;

  @override
  void execute([RdSignal event = null]) {
    super.execute(event);

    StateChangeVO e = event.data;
    _currentVO = e.oldVO;
    _nextVO = e.newVO;
    bool modal = false;

    if (stateModel.currentState == StateConstants.MAIN_TRANSITIONING) {
      stateModel.currentTransition.cancel();

      if (stateModel.compositeTransitionCommand != null) {
        stateModel.compositeTransitionCommand.cancel();
        stateModel.compositeTransitionCommand = null;
      }

      if (stateModel.compositeEffectCommand != null) {
        stateModel.compositeEffectCommand.cancel();
        stateModel.compositeEffectCommand = null;
      }

//				TweenMax.killAll();
    }

    _currentStateElement = null;

    if (stateModel.currentScreen != null &&
        _currentVO != null &&
        _nextVO != null &&
        stateModel.currentScreen.name == _nextVO.view_id &&
        _currentVO.substate == StateConstants.SUB_MODAL) {
      //do not retrieve nextStateElement from Context, since it is already present as modal background. see handling in switch/case below
    } else {
      _nextStateElement = applicationContext.getObject(_nextVO.view_id, [_nextVO.view_id]);

      if (_nextVO.params != null) {
        _nextStateElement.params = _nextVO.params;
      }
    }

    stateModel.currentState = StateConstants.MAIN_TRANSITIONING;
    stateModel.currentTransition = applicationContext.getObject(_nextVO.transition);
    String transitionType = "";

    if (_currentVO == null) {
      // 1. nullToNormal
      transitionType = ScreenConstants.TRANSITION_NONE_TO_NORMAL;
      stateModel.currentScreen = _nextStateElement;
    } else {
      if (_currentVO.substate == StateConstants.SUB_MODAL) {
        if (stateModel.currentScreen.name == _nextVO.view_id) {
          // 5.modalBack. _nextStateElement hasn't been created (line 36)
          transitionType = ScreenConstants.TRANSITION_MODAL_BACK;
          stateModel.currentTransition = applicationContext.getObject("transition.default.modal");
          _nextStateElement = stateModel.currentScreen;
        } else if (_nextVO.substate == StateConstants.SUB_MODAL) {
          // 4. modalToModal
          transitionType = ScreenConstants.TRANSITION_MODAL_TO_MODAL;
          modal = true;
        } else {
          // 6. modalToNormal
          _currentStateElement = stateModel.currentScreen;
          stateModel.currentScreen = _nextStateElement;
          transitionType = ScreenConstants.TRANSITION_MODAL_TO_NORMAL;
        }
      } else if (_nextVO.substate == StateConstants.SUB_MODAL) {
        // 3. normalToModal
        _currentStateElement = stateModel.currentScreen;
        transitionType = ScreenConstants.TRANSITION_NORMAL_TO_MODAL;
        modal = true;
        stateModel.currentScreen.enabled = false;
      } else {
        // 2. normalToNormal
        _currentStateElement = stateModel.currentScreen;
        stateModel.currentScreen = _nextStateElement;
        transitionType = ScreenConstants.TRANSITION_NORMAL_TO_NORMAL;
      }
    }

    new RdSignal(
            ScreenDisplaylistEvents.TRANSITION_PREPARE,
            new ScreenDisplaylistTransitionPrepareVO(
                transitionType, _currentStateElement, stateModel.currentTransition, _nextStateElement,
                modal: modal, initialAlpha: stateModel.currentTransition.initialAlpha),
            _onTransitionEnd)
        .dispatch();
  }

  void _onTransitionEnd([dynamic payload = null]) {
    stateModel.currentState = StateConstants.MAIN_PRESENTING;

    if (_nextVO.substate == StateConstants.SUB_MODAL) {
      stateModel.modalizedScreen = stateModel.currentScreen;
    }

    dispatchCompleteEvent();
  }
}
