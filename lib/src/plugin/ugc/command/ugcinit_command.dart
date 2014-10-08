part of stagexl_rockdot;



@retain
class UGCInitCommand extends AbstractUGCCommand {

  @override dynamic execute([RockdotEvent event = null]) {
    super.execute(event);

    this.log.info("Connecting to AMF Host: " + _context.propertiesProvider.getProperty("project.host.amf").toString());
/*
    NetConnection nc = new NetConnection();
    nc.addEventListener(NetStatusEvent.NET_STATUS, _netStatusHandler);
    nc.addEventListener(SecurityErrorEvent.SECURITY_ERROR, _securityErrorHandler);
    String url = _context.propertiesProvider.getProperty("project.host.amf");
    nc.connect(url);
    _ugcModel.service = nc;
*/
    dispatchCompleteEvent();
  }
  void _securityErrorHandler(SecurityErrorEvent event) {
    log.error(event.text);
  }
  void _netStatusHandler(NetStatusEvent event) {
    //possible values see http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/events/NetStatusEvent.html#NET_STATUS
    this.log.info("NetStatusEvent.NET_STATUS: " + event.info.code);
  }
}
