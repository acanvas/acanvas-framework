part of stagexl_rockdot;

@retain
class UGCReadItemContainerCommand extends AbstractUGCCommand {

  @override void execute([RockdotEvent event = null]) {
    super.execute(event);

    //event.data == id INT
    Map dto = {
      'id': event.data
    };

    amfOperation("UGCEndpoint.readItemContainer", dto);
  }

  @override bool dispatchCompleteEvent([dynamic result = null]) {
    UGCItemContainerVO ret;
    if (result.result.length > 0) {
      ret = new UGCItemContainerVO(result.result[0]);
      ret.items = result.result[0].items;
      ret.roles = result.result[0].roles;
      ret.task = new UGCTaskVO(result.result[0].task);
      _ugcModel.currentItemContainerDAO = ret;
    }
    return super.dispatchCompleteEvent(ret);
  }
}
