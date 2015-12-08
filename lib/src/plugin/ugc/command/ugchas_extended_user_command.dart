part of stagexl_rockdot.ugc;

//@retain
class UGCHasExtendedUserCommand extends AbstractUGCCommand {

  @override dynamic execute([RdSignal event=null]) {
    super.execute(event);

    Map dto = {'uid': event.data ? event.data : _ugcModel.userDAO.uid};

    amfOperation("UGCEndpoint.hasUserExtended", map: dto);
    return null;
  }

  @override bool dispatchCompleteEvent([dynamic result=null]) {
    if (result.result == true) {
      _ugcModel.hasUserExtendedDAO = true;
    }
    return super.dispatchCompleteEvent(result.result);
  }

}

