part of rockdot_framework.ugc;


class UGCReadItemContainerCommand extends AbstractUGCCommand {
  @override
  void execute([RdSignal event = null]) {
    super.execute(event);

    //event.data == id INT
    Map dto = {'id': event.data};

    amfOperation("UGCEndpoint.readItemContainer", map: dto);
  }

  @override
  bool dispatchCompleteEvent([dynamic result = null]) {
    UGCItemContainerDTO ret;
    if (result.length > 0) {
      ret = new UGCItemContainerDTO(result[0]);
      _ugcModel.currentItemContainerDAO = ret;
    }
    return super.dispatchCompleteEvent(ret);
  }
}
