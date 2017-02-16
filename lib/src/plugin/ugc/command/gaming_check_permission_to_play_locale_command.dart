part of rockdot_framework.ugc;

//@retain
class GamingCheckPermissionToPlayLocaleCommand extends AbstractUGCCommand {
  @override
  void execute([RdSignal event = null]) {
    super.execute(event);

    Map dto = {'uid': _ugcModel.userDAO.uid, 'locale': RdConstants.LANGUAGE + "_" + RdConstants.MARKET};

    amfOperation("GamingEndpoint.checkPermissionToPlayLocale", map: dto);
  }

  @override
  bool dispatchCompleteEvent([dynamic result = null]) {
    _ugcModel.gaming.allowedToPlay = result.result;
    return super.dispatchCompleteEvent(_ugcModel.gaming.allowedToPlay);
  }
}
