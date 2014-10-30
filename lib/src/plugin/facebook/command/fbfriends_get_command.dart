part of stagexl_rockdot;

@retain
class FBFriendsGetCommand extends AbstractFBCommand {

  @override void execute([RockdotEvent event = null]) {
    super.execute(event);
//      showMessage("notification.facebook.loading")

    String uid = _fbModel.user.uid;

    js.JsObject queryConfig = new js.JsObject.jsify({});
    _fbModel.FB.callMethod("api", ["/$uid/friends", "get", queryConfig, _handleResult]);
  }

  void _handleResult(js.JsObject response) {
//      hideMessage("notification.facebook.loading")
    if (containsError(response)) return;

    Map friends = {};
    response["data"].forEach((e) {
      friends[e["id"]] = e["name"];
    });

    _fbModel.friends = friends;
    dispatchCompleteEvent(friends);
  }
}
