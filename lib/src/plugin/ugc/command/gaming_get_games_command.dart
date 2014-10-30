part of stagexl_rockdot;

@retain
class GamingGetGamesCommand extends AbstractUGCCommand {

  @override void execute([RockdotEvent event = null]) {
    super.execute(event);

    Map dto = {
      'uid': _ugcModel.userDAO.uid
    };

    amfOperation("GamingEndpoint.getGames", dto);
  }

  @override bool dispatchCompleteEvent([dynamic result = null]) {
    _ugcModel.gaming.games = result.result.games;
    return super.dispatchCompleteEvent(result.result);
  }
}
