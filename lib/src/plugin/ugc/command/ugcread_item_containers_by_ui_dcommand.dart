part of stagexl_rockdot;

@retain
class UGCReadItemContainersByUIDCommand extends AbstractUGCCommand {

  @override void execute([RockdotEvent event = null]) {
    super.execute(event);
    if (event.data) {

      Map dto = {
        'uid': event.data
      };

      amfOperation("UGCEndpoint.readItemContainersByUID", dto);
    } else {
      dispatchErrorEvent("No UID");
    }
  }


  @override bool dispatchCompleteEvent([dynamic result = null]) {
    _ugcModel.ownContainers = _createContainers(result.result.ownContainers);
    _ugcModel.followContainers = _createContainers(result.result.followContainers);
    _ugcModel.participantContainers = _createContainers(result.result.participantContainers);
    return super.dispatchCompleteEvent();
  }
  List _createContainers(List result) {
    List a_ret = [];

    if (result.length > 0) {
      UGCItemContainerVO ret;

      for (int i = 0; i < result.length; i++) {
        ret = new UGCItemContainerVO(result[i]);
        a_ret.add(ret);
      }
    }

    return a_ret;
  }
}
