part of rockdot_framework.ugc;


class UGCReadItemCommand extends AbstractUGCCommand {
  @override
  void execute([RdSignal event = null]) {
    super.execute(event);

    //event.data == id INT
    Map dto = {'id': event.data};

    amfOperation("UGCEndpoint.readItem", map: dto);
  }

  @override
  bool dispatchCompleteEvent([dynamic result = null]) {
    UGCItemDTO ret;
    if (result.length > 0) {
      ret = new UGCItemDTO(result[0]);
      _ugcModel.currentItemDAO = ret;
    }
    return super.dispatchCompleteEvent(ret);
  }
}
