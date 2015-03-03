part of stagexl_rockdot.ugc;

@retain
class UGCInitCommand extends AbstractUGCCommand {

  @override void execute([XLSignal event = null]) {
    super.execute(event);

    this.log.info("Will use following host: " + applicationContext.propertiesProvider.getProperty("project.host.json").toString());
    dispatchCompleteEvent();
  }
}
