part of rockdot_framework.screen;

//@retain
class ScreenPluginInitCommand extends AbstractScreenCommand {

  @override dynamic execute([RdSignal event=null]) {
    super.execute(event);

    IScreenService _uiService = applicationContext.getObject(ScreenPluginBase.SERVICE_UI);
    _uiService.init(dispatchCompleteEvent);
    return;

  }
}

