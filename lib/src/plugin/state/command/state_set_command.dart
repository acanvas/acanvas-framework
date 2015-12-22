part of rockdot_framework.state;

/**
 * @author Nils Doehring (nilsdoehring(gmail as at).com)
 */
//@retain
class StateSetCommand extends AbstractStateCommand {
  @override dynamic execute([RdSignal event = null]) {
    super.execute(event);

    bool saveHistory = true;
    if (_stateModel.historyCount > 0 && _stateModel.history[_stateModel.historyCount].url == event.data.url) {
      saveHistory = false;
    }

    _setStateVO(event.data, saveHistory);
    this.log.finer("Go  to: count {0}, url {1}, history: {2}", [_stateModel.historyCount, _stateModel.history[_stateModel.historyCount].url, saveHistory]);

    return null;
  }

  void _setStateVO(StateVO stateVO, bool saveToHistory) {

    if (_stateModel.currentStateVO == null || stateVO.url != _stateModel.currentStateVO.url) {
      // initial view after app start

      StateVO oldStateVO = _stateModel.currentStateVO;

      _stateModel.currentStateVO = stateVO;
      _stateModel.currentStateURLParams = stateVO.params;

      new RdSignal(StateEvents.STATE_CHANGE, new StateChangeVO(oldStateVO, stateVO), dispatchCompleteEvent).dispatch();
      new RdSignal(StateEvents.STATE_PARAMS_CHANGE, _stateModel.currentStateVO).dispatch();

      if (saveToHistory) {
        _addToHistory(_stateModel.currentStateVO);
      }
    } else {
      // Same naviVO, check if params have changed.
      if (stateVO.params != _stateModel.currentStateURLParams) {
        // Different params
        _stateModel.currentStateURLParams = stateVO.params;

        _stateModel.addressService.onAddressChanged(_stateModel.currentStateVO);
        if (_stateModel.currentScreen != null) {
          _stateModel.currentScreen.params = _stateModel.currentStateURLParams;
        }
      } else {
        // Same params. Do nothing.
      }
    }

  }

  void _addToHistory(StateVO stateVO) {
    _stateModel.historyCount++;
    _stateModel.history.add(stateVO);

    // Cleanup
    int n = _stateModel.history.length;
    for (int i = _stateModel.historyCount + 1; i < n; i++) {
      _stateModel.history.removeLast();
    }

    n = _stateModel.history.length;
    String history = "";
    for (int i = 0; i < n; i++) {
      history += _stateModel.history.elementAt(i).view_id + ", ";
    }
    this.log.finer("History: " + history);
  }
}
