part of rockdot_framework.facebook;

//@retain
class FBFriendsGetCommand extends AbstractFBCommand {
  DataRetrieveVO _vo;

  @override void execute([RdSignal event = null]) {
    super.execute(event);

    if (notLoggedIn(event)) return;

    if (event.data != null && event.data is DataRetrieveVO) {
      _vo = event.data;
    }

    String uid = _fbModel.user.uid;

    js.JsObject queryConfig = new js.JsObject.jsify({
      "fields": "name,picture.width(100).height(100)"
    });
    _fbModel.FB.callMethod("api", ["/$uid/taggable_friends", "get", queryConfig, _handleResult]);

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

    if (_vo != null) {
      _vo.nextToken = response["paging"]["cursors"]["after"];
      _vo.totalSize = response["data"].length;
      dispatchCompleteEvent(response["data"]);
    }
    else {
      dispatchCompleteEvent(friends);
    }
  }
}
