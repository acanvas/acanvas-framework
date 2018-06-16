part of acanvas_framework.state;

class AbstractStateCommand extends AcCommand implements IStateModelAware {
  StateModel _stateModel;

  StateModel get stateModel => _stateModel;

  void set stateModel(StateModel stateModel) {
    _stateModel = stateModel;
  }
}
