part of acanvas_framework.screen;

class ScreenPluginInitCommand extends AbstractScreenCommand {
  @override
  dynamic execute([AcSignal event = null]) {
    super.execute(event);

    IScreenService _uiService =
        applicationContext.getObject(ScreenPluginBase.SERVICE_UI);
    _uiService.init(dispatchCompleteEvent);
    return;
  }
}
