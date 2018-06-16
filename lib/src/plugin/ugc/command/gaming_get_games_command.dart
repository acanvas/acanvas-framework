part of acanvas_framework.ugc;

class GamingGetGamesCommand extends AbstractUGCCommand {
  @override
  void execute([AcSignal event = null]) {
    super.execute(event);

    Map dto = {'uid': _ugcModel.userDAO.uid};

    amfOperation("GamingEndpoint.getGames", map: dto);
  }

  @override
  bool dispatchCompleteEvent([dynamic result = null]) {
    _ugcModel.gaming.games = result.games;
    return super.dispatchCompleteEvent(result);
  }
}
