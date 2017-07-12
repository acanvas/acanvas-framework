part of rockdot_framework.ugc;

//@retain
class UGCCreateItemContainerCommand extends AbstractUGCCommand {
  @override
  void execute([RdSignal event = null]) {
    super.execute(event);
    if (event.data is UGCItemContainerDTO) {
      _ugcModel.currentItemContainerDAO = event.data;
    }
    amfOperation("UGCEndpoint.createItemContainer", dto: _ugcModel.currentItemContainerDAO);
  }

  @override
  bool dispatchCompleteEvent([dynamic result = null]) {
    if(result is int){
      _ugcModel.currentItemContainerDAO.id = result;
      if (_ugcModel.currentItemDAO != null) {
        _ugcModel.currentItemDAO.container_id = result;
      }
      return super.dispatchCompleteEvent(result);
    }
    else{

      dispatchErrorEvent("Endpoint didn't return an int.");
      return false;
    }
  }
}
