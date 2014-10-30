part of stagexl_rockdot;


@retain
class FBUserGetInfoCommand extends AbstractFBCommand {

  @override
  void execute([RockdotEvent event = null]) {
    super.execute(event);
//			dispatchMessage("loading.facebook.login");

    js.JsObject queryConfig = new js.JsObject.jsify({
      "method": "fql.query",
      "query": "SELECT uid, name, pic_square, is_app_user, birthday_date, email, hometown_location, locale FROM user WHERE uid = ${_fbModel.user.uid}"
    });
    
    _fbModel.FB.callMethod("api", [queryConfig, _handleResult]);
  }

  void _handleResult(js.JsArray response) {
    if(containsError(response)) return;

    if (response == null || response[0] == null) {
      error = ("Error parsing user from response");
      dispatchErrorEvent();
      return;
    }
    
    FBUserVO user = new FBUserVO(response[0]);
    _fbModel.user = user;

    dispatchCompleteEvent(user);
  }
}
