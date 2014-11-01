part of stagexl_rockdot;

/**
	 * @author Nils Doehring (nilsdoehring(gmail as at).com)
	 */
@retain
class StateSetCommand extends AbstractStateCommand {
  @override dynamic execute([XLSignal event = null]) {
    super.execute(event);

    bool saveHistory = true;
    if (_stateModel.historyCount > 0 && _stateModel.history[_stateModel.historyCount].url == event.data.url) {
      saveHistory = false;
    }

    _setStateVO(event.data, saveHistory);
    this.log.finer("Go  to: count {0}, url {1}, history: {2}", [_stateModel.historyCount, _stateModel.history[_stateModel.historyCount].url, saveHistory]);
  }
  void _setStateVO(StateVO stateVO, bool saveToHistory) {
    if (_stateModel.currentStateVO == null || stateVO.url != _stateModel.currentStateVO.url) {
      // initial view after app start
      bool naviVOwasNull = false;
      if (_stateModel.currentStateVO == null) {
        naviVOwasNull = true;
      }

      StateVO oldNaviVO = _stateModel.currentStateVO;

      _stateModel.currentStateVO = stateVO;
      _stateModel.currentPageVOParams = stateVO.params;
      new XLSignal(StateEvents.STATE_CHANGE, new StateChangeVO(oldNaviVO, stateVO), dispatchCompleteEvent).dispatch();

      if (naviVOwasNull) {
        new XLSignal(StateEvents.STATE_PARAMS_CHANGE, _stateModel.currentStateVO).dispatch();
      }

      if (saveToHistory) {
        _addToHistory(_stateModel.currentStateVO);
      }
    } else {
      // Same naviVO, check if params have changed.
      if (stateVO.params != _stateModel.currentPageVOParams) {
        // Different params
        _stateModel.currentPageVOParams = stateVO.params;

        _stateModel.addressService.onAddressChanged(_stateModel.currentStateVO);
        if (_stateModel.currentPage != null) {
          _stateModel.currentPage.setData(_stateModel.currentPageVOParams);
        }
      } else {
        // Same params. Do nothing.
      }
    }
  }
  void _addToHistory(StateVO naviVO) {
    _stateModel.historyCount++;
    _stateModel.history.add(naviVO);

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
