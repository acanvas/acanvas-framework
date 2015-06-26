part of stagexl_rockdot.ugc;

//@retain
class UGCReadItemCommand extends AbstractUGCCommand {

  @override void execute([XLSignal event = null]) {
    super.execute(event);

    //event.data == id INT
    Map dto = {
      'id': event.data
    };

    amfOperation("UGCEndpoint.readItem", map: dto);
  }

  @override bool dispatchCompleteEvent([dynamic result = null]) {
    UGCItemDTO ret;
    if (result.result.length > 0) {
      ret = new UGCItemDTO(result.result[0]);
      _ugcModel.currentItemDAO = ret;
    }
    return super.dispatchCompleteEvent(ret);
  }
}
