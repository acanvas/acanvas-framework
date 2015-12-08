part of stagexl_rockdot.ugc;

//@retain
class UGCReadItemContainerCommand extends AbstractUGCCommand {

  @override void execute([RdSignal event = null]) {
    super.execute(event);

    //event.data == id INT
    Map dto = {
      'id': event.data
    };

    amfOperation("UGCEndpoint.readItemContainer", map: dto);
  }

  @override bool dispatchCompleteEvent([dynamic result = null]) {
    UGCItemContainerDTO ret;
    if (result.result.length > 0) {
      ret = new UGCItemContainerDTO(result.result[0]);
      ret.items = result.result[0].items;
      ret.roles = result.result[0].roles;
      ret.task = new UGCTaskDTO(result.result[0].task);
      _ugcModel.currentItemContainerDAO = ret;
    }
    return super.dispatchCompleteEvent(ret);
  }
}
