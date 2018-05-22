part of rockdot_framework.ugc;

class UGCHasExtendedUserCommand extends AbstractUGCCommand {
  @override
  dynamic execute([RdSignal event = null]) {
    super.execute(event);

    Map dto = {'uid': event.data ? event.data : _ugcModel.userDAO.uid};

    amfOperation("UGCEndpoint.hasUserExtended", map: dto);
    return null;
  }

  @override
  bool dispatchCompleteEvent([dynamic result = null]) {
    if (result == true) {
      _ugcModel.hasUserExtendedDAO = true;
    }
    return super.dispatchCompleteEvent(result);
  }
}
