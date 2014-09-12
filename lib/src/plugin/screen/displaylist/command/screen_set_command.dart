part of rockdot_dart;




/**
	 * @author Nils Doehring (nilsdoehring(gmail as at).com)
	 */
@retain
class ScreenSetCommand extends AbstractStateCommand {
  StateVO _currentVO;
  StateVO _nextVO;
  IManagedSpriteComponent _currentStateElement;
  IManagedSpriteComponent _nextStateElement;

  @override dynamic execute([RockdotEvent event = null]) {
    super.execute(event);

    VOStateChange e = event.data;
    _currentVO = e.oldVO;
    _nextVO = e.newVO;
    bool modal = false;

    if (_stateModel.currentState == StateConstants.MAIN_TRANSITIONING) {

      _stateModel.currentTransition.cancel();

      if (_stateModel.compositeTransitionCommand != null) {
        _stateModel.compositeTransitionCommand.cancel();
        _stateModel.compositeTransitionCommand = null;
      }

      if (_stateModel.compositeEffectCommand != null) {
        _stateModel.compositeEffectCommand.cancel();
        _stateModel.compositeEffectCommand = null;
      }

//				TweenMax.killAll();
    }

    _currentStateElement = null;

    if (_stateModel.currentPage != null && _currentVO != null && _nextVO != null && _stateModel.currentPage.name == _nextVO.view_id && _currentVO.substate == StateConstants.SUB_MODAL) {
      //do not retrieve nextStateElement from Context, since it is already present as modal background. see handling in switch/case below
    } else {
      _nextStateElement = _context.getObject(_nextVO.view_id, [_nextVO.view_id]);

      if (_nextVO.params != null) {
        _nextStateElement.setData(_nextVO.params);
      }
    }

    _stateModel.currentState = StateConstants.MAIN_TRANSITIONING;
    _stateModel.currentTransition = _context.getObject(_nextVO.transition);
    String transitionType = "";

    if (_currentVO == null) {
      // 1. nullToNormal
      transitionType = ScreenConstants.TRANSITION_NONE_TO_NORMAL;
      _stateModel.currentPage = _nextStateElement;
    } else {

      if (_currentVO.substate == StateConstants.SUB_MODAL) {

        if (_stateModel.currentPage.name == _nextVO.view_id) {
          // 5.modalBack. _nextStateElement hasn't been created (line 36)
          transitionType = ScreenConstants.TRANSITION_MODAL_BACK;
          _stateModel.currentTransition = _context.getObject("transition.default.modal");
          _nextStateElement = _stateModel.currentPage;
        } else if (_nextVO.substate == StateConstants.SUB_MODAL) {
          // 4. modalToModal
          transitionType = ScreenConstants.TRANSITION_MODAL_TO_MODAL;
          modal = true;
        } else {
          // 6. modalToNormal
          _currentStateElement = _stateModel.currentPage;
          _stateModel.currentPage = _nextStateElement;
          transitionType = ScreenConstants.TRANSITION_MODAL_TO_NORMAL;
        }
      } else if (_nextVO.substate == StateConstants.SUB_MODAL) {
        // 3. normalToModal
        _currentStateElement = _stateModel.currentPage;
        transitionType = ScreenConstants.TRANSITION_NORMAL_TO_MODAL;
        modal = true;
        _stateModel.currentPage.enabled = false;
      } else {
        // 2. normalToNormal
        _currentStateElement = _stateModel.currentPage;
        _stateModel.currentPage = _nextStateElement;
        transitionType = ScreenConstants.TRANSITION_NORMAL_TO_NORMAL;
      }
    }

    new RockdotEvent(ScreenDisplaylistEvents.TRANSITION_PREPARE, new ScreenDisplaylistTransitionPrepareVO(transitionType, _currentStateElement, _stateModel.currentTransition, _nextStateElement, modal, _stateModel.currentTransition.initialAlpha), _onTransitionEnd).dispatch();
  }
  void _onTransitionEnd([dynamic payload = null]) {
    _stateModel.currentState = StateConstants.MAIN_PRESENTING;

    if (_nextVO.substate == StateConstants.SUB_MODAL) {
      _stateModel.currentSubState = StateConstants.SUB_MODAL;
      _stateModel.modalizedPage = _stateModel.currentPage;
    }

    dispatchCompleteEvent();
  }
}
