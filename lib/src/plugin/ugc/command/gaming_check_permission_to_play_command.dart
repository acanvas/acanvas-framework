part of stagexl_rockdot;

@retain
class GamingCheckPermissionToPlayCommand extends AbstractUGCCommand {

  @override void execute([RockdotEvent event = null]) {
    super.execute(event);

    Map dto = {
      'uid': _ugcModel.userDAO.uid
    };

    amfOperation("GamingEndpoint.checkPermissionToPlay", dto);
  }


  @override bool dispatchCompleteEvent([dynamic result = null]) {
    _ugcModel.gaming.allowedToPlay = result.result;
    return super.dispatchCompleteEvent(_ugcModel.gaming.allowedToPlay);
  }
}
