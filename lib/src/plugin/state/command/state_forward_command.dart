part of stagexl_rockdot.state;

/**
 * @author Nils Doehring (nilsdoehring(gmail as at).com)
 */
//@retain
class StateForwardCommand extends AbstractStateCommand {
  @override dynamic execute([RdSignal event=null]) {
    super.execute(event);

    if (_stateModel.historyCount != _stateModel.history.length - 1) {
      _stateModel.historyCount++;
      this.log.finer("Go forward to: count {0}, url {1}, history: false", [_stateModel.historyCount, _stateModel.history[_stateModel.historyCount].url]);
    }
    new RdSignal(StateEvents.ADDRESS_SET, _stateModel.history[_stateModel.historyCount].url, dispatchCompleteEvent).dispatch();

    return null;
  }
}

