part of stagexl_rockdot;

@retain
class UGCReadItemCommand extends AbstractUGCCommand {

  @override void execute([RockdotEvent event = null]) {
    super.execute(event);

    //event.data == id INT
    Map dto = {
      'id': event.data
    };

    amfOperation("UGCEndpoint.readItem", dto);
  }

  @override bool dispatchCompleteEvent([dynamic result = null]) {
    UGCItemVO ret;
    if (result.result.length > 0) {
      ret = new UGCItemVO(result.result[0]);
      _ugcModel.currentItemDAO = ret;
    }
    return super.dispatchCompleteEvent(ret);
  }
}
