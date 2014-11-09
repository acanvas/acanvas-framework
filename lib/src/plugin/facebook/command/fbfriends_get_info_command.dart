part of stagexl_rockdot;

@retain
class FBFriendsGetInfoCommand extends AbstractFBCommand {

  @override void execute([XLSignal event = null]) {
    super.execute(event);

    List arr = [];

    _fbModel.friends.keys.forEach((key) {
      arr.add(key);
    });

    js.JsObject queryConfig = new js.JsObject.jsify({
      "method": "fql.query",
      "query": "SELECT uid, name, pic_square, is_app_user FROM user WHERE uid = me() OR uid IN ( ${arr.join(",")} )"
    });

    _fbModel.FB.callMethod("api", [queryConfig, _handleResult]);
    
    showMessage(getProperty("message.facebook.loading.data"));
  }

  void _handleResult(js.JsArray response) {
    hideMessage();
    
    if (containsError(response)) return;

    List friendsWithAdditionalInfo = [];
    response["data"].forEach((e) {
      friendsWithAdditionalInfo.add(new FBUserVO(e));
    });

    _fbModel.friendsWithAdditionalInfo = friendsWithAdditionalInfo;
    dispatchCompleteEvent(friendsWithAdditionalInfo);
  }
}
