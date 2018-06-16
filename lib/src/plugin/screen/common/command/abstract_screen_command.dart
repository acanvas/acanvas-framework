part of acanvas_framework.screen;

class AbstractScreenCommand extends AcCommand
    implements IScreenServiceAware, IStateModelAware {
  IScreenService _uiService;

  void set uiService(IScreenService uiService) {
    _uiService = uiService;
  }

  StateModel _stateModel;

  void set stateModel(StateModel stateModel) {
    _stateModel = stateModel;
  }
}
