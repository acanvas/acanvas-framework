part of stagexl_rockdot.screen;

class AbstractScreenCommand extends RdCommand implements IScreenModelAware, IScreenServiceAware, IStateModelAware {

  ScreenModel _uiModel;

  void set uiModel(ScreenModel uiModel) {
    _uiModel = uiModel;
  }

  IScreenService _uiService;

  void set uiService(IScreenService uiService) {
    _uiService = uiService;
  }

  StateModel _stateModel;

  void set stateModel(StateModel stateModel) {
    _stateModel = stateModel;
  }

}

