part of rockdot_framework.ugc;

//@retain
class UGCFriendsReadCommand extends AbstractUGCCommand implements IFBModelAware {
  FBModel _modelFB;

  void set fbModel(FBModel model) {
    _modelFB = model;
  }

  @override
  void execute([RdSignal event = null]) {
    super.execute(event);

    if (_modelFB.friendsWhoAreAppUsers == null) {
      dispatchCompleteEvent(new List());
      return null;
    }

    List arr = [];

    _modelFB.friendsWhoAreAppUsers.forEach((k, v) {
      arr.add(v.id);
    });

    Map dto = {"ids": arr};

    amfOperation("UGCEndpoint.getFriendsWithItems", map: dto);
  }

  @override
  bool dispatchCompleteEvent([dynamic event = null]) {
    List arr = [];

    for (int i = 0; i < event.result.length; i++) {
      FBUserVO user = _modelFB.friendsWhoAreAppUsers[event.result[i]];
      arr.add(user);
    }

    _ugcModel.friendsWithUGCItems = arr;
    return dispatchCompleteEvent(arr);
  }
}
