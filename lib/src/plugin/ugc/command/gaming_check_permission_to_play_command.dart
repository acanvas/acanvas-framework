part of rockdot_framework.ugc;

class GamingCheckPermissionToPlayCommand extends AbstractUGCCommand {
  @override
  void execute([RdSignal event = null]) {
    super.execute(event);

    Map dto = {'uid': _ugcModel.userDAO.uid};

    amfOperation("GamingEndpoint.checkPermissionToPlay", map: dto);
  }

  @override
  bool dispatchCompleteEvent([dynamic result = null]) {
    _ugcModel.gaming.allowedToPlay = result;
    return super.dispatchCompleteEvent(_ugcModel.gaming.allowedToPlay);
  }
}
