part of rockdot_framework.ugc;

//@retain
class UGCCreateItemContainerCommand extends AbstractUGCCommand {

  @override void execute([RdSignal event = null]) {
    super.execute(event);
    if (event.data is UGCItemContainerDTO) {
      _ugcModel.currentItemContainerDAO = event.data;
    }
    amfOperation("UGCEndpoint.createItemContainer", dto: _ugcModel.currentItemContainerDAO);
  }


  @override bool dispatchCompleteEvent([dynamic result = null]) {
    _ugcModel.currentItemContainerDAO.id = result.result;
    if (_ugcModel.currentItemDAO != null) {
      _ugcModel.currentItemDAO.container_id = result.result;
    }
    return super.dispatchCompleteEvent(result);
  }
}
