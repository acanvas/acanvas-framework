part of rockdot_framework.state;


class AbstractStateCommand extends RdCommand implements IStateModelAware, IScreenModelAware {

  ScreenModel _uiModel;

  void set uiModel(ScreenModel uiModel) {
    _uiModel = uiModel;
  }

  StateModel _stateModel;

  StateModel get stateModel => _stateModel;

  void set stateModel(StateModel stateModel) {
    _stateModel = stateModel;
  }

}

