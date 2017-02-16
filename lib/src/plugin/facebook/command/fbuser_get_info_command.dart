part of rockdot_framework.facebook;

//@retain
class FBUserGetInfoCommand extends AbstractFBCommand {
  @override
  void execute([RdSignal event = null]) {
    super.execute(event);

    if (notLoggedIn(event)) return;
    showMessage(getProperty("message.facebook.loading.data"));

    js.JsObject queryConfig = new js.JsObject.jsify({
      "method": "fql.query",
      "query":
          "SELECT uid, name, pic_square, is_app_user, birthday_date, email, hometown_location, locale FROM user WHERE uid = ${_fbModel.user.uid}"
    });

    _fbModel.FB.callMethod("api", [queryConfig, _handleResult]);
  }

  void _handleResult(js.JsArray response) {
    hideMessage();

    if (containsError(response)) return;

    FBUserVO user = new FBUserVO(response[0]);
    _fbModel.user = user;

    dispatchCompleteEvent(user);
  }
}
