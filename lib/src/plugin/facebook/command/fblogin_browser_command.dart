part of stagexl_rockdot.facebook;

//@retain
class FBLoginBrowserCommand extends AbstractFBCommand {
  RdSignal _nextSignal;

  @override
  void execute([RdSignal event = null]) {
    super.execute(event);

    String scopes = "";
    if (event.data != null && event.data is FacebookLoginVO) {
      _nextSignal = event.data.nextSignal;
      scopes = event.data.scopes != null ? event.data.scopes : getProperty("project.facebook.scopes");
    }

    if (_fbModel.userIsAuthenticated && event.data == "") {
      if (_nextSignal != null) {
        _nextSignal.dispatch();
      }
      dispatchCompleteEvent();
    } else {
      showMessage(getProperty("message.facebook.login.waiting"), blur: true, type: StateMessageVO.TYPE_WAITING);

      js.JsObject loginConfig = new js.JsObject.jsify({
        "scope": scopes,
        "return_scopes": true
      });

      _fbModel.FB.callMethod("login", [_handleLogin, loginConfig]);
    }
  }

  void _handleLogin(js.JsObject response, [js.JsObject fail = null]) {
    hideMessage();

    if (containsError(response)) return;

    if (response["authResponse"] != null) {

      _fbModel.accessToken = response["authResponse"]["accessToken"];
      _fbModel.userIsAuthenticated = true;
      _fbModel.user = new FBUserVO()
        ..uid = response["authResponse"]["userID"];

      if (response["authResponse"]["grantedScopes"] != null) {
        _fbModel.userPermissions = response["authResponse"]["grantedScopes"].split(",");
        //TODO check if the requested permissions have been granted (because user could have clicked "not now")
      }

      if (_nextSignal != null) {
        _nextSignal.dispatch();
      }

      dispatchCompleteEvent();
    } else {
      this.log.debug("Received empty callback");
      hideMessage();
      dispatchErrorEvent();
    }
  }
}
