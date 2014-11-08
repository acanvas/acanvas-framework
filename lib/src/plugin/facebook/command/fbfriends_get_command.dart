part of stagexl_rockdot;

@retain
class FBFriendsGetCommand extends AbstractFBCommand {

  @override void execute([XLSignal event = null]) {
    super.execute(event);

    String uid = _fbModel.user.uid;

    js.JsObject queryConfig = new js.JsObject.jsify({});
    _fbModel.FB.callMethod("api", ["/$uid/friends", "get", queryConfig, _handleResult]);

    showMessage(getProperty("message.facebook.loading.data"));
  }

  void _handleResult(js.JsObject response) {
    hideMessage();
    
    if (containsError(response)) return;

    Map friends = {};
    response["data"].forEach((e) {
      friends[e["id"]] = e["name"];
    });

    _fbModel.friends = friends;
    dispatchCompleteEvent(friends);
  }
}
