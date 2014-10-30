part of stagexl_rockdot;

@retain
class FBFriendsGetInfoCommand extends AbstractFBCommand {

  @override void execute([RockdotEvent event = null]) {
    super.execute(event);

    //showMessage("notification.facebook.loading")
    List arr = [];

    _fbModel.friends.keys.forEach((key) {
      arr.add(key);
    });

    js.JsObject queryConfig = new js.JsObject.jsify({
      "method": "fql.query",
      "query": "SELECT uid, name, pic_square, is_app_user FROM user WHERE uid = me() OR uid IN ( ${arr.join(",")} )"
    });

    _fbModel.FB.callMethod("api", [queryConfig, _handleResult]);
  }

  void _handleResult(js.JsArray response) {
//      hideMessage("notification.facebook.loading")
    if (containsError(response)) return;

    List friendsWithAdditionalInfo = [];
    response["data"].forEach((e) {
      friendsWithAdditionalInfo.add(new FBUserVO(e));
    });

    _fbModel.friendsWithAdditionalInfo = friendsWithAdditionalInfo;
    dispatchCompleteEvent(friendsWithAdditionalInfo);
  }
}
