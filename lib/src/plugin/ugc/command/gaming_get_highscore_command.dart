part of stagexl_rockdot.ugc;

@retain
class GamingGetHighscoreCommand extends AbstractUGCCommand implements IFBModelAware {
  FBModel _modelFB;
  void set fbModel(FBModel model) {
    _modelFB = model;
  }

  @override void execute([XLSignal event = null]) {
    super.execute(event);

    Map dto = {
      'uid': _ugcModel.userDAO.uid,
      'friends': _modelFB.friendsWhoAreAppUsersIndexed
    };

    amfOperation("GamingEndpoint.getHighscore", map: dto);
  }


  @override bool dispatchCompleteEvent([dynamic result = null]) {
    _ugcModel.gaming.highscoreFriends = result.result.topFiveFriends;
    _ugcModel.gaming.highscoreAll = result.result.topTen;
    _ugcModel.gaming.rank = result.result.rank;
    return super.dispatchCompleteEvent(result.result);
  }
}
