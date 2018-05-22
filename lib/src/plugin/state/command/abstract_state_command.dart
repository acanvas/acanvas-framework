part of rockdot_framework.state;

class AbstractStateCommand extends RdCommand implements IStateModelAware {
  StateModel _stateModel;

  StateModel get stateModel => _stateModel;

  void set stateModel(StateModel stateModel) {
    _stateModel = stateModel;
  }
}
