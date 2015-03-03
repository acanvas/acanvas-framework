part of stagexl_rockdot.ugc;

@retain
class GamingCheckPermissionToPlayCommand extends AbstractUGCCommand {

  @override void execute([XLSignal event = null]) {
    super.execute(event);

    Map dto = {
      'uid': _ugcModel.userDAO.uid
    };

    amfOperation("GamingEndpoint.checkPermissionToPlay", map: dto);
  }


  @override bool dispatchCompleteEvent([dynamic result = null]) {
    _ugcModel.gaming.allowedToPlay = result.result;
    return super.dispatchCompleteEvent(_ugcModel.gaming.allowedToPlay);
  }
}
