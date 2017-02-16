part of rockdot_framework.facebook;

//@retain
class FBInitBrowserCommand extends AbstractFBCommand {
  String facebookSDKUrl = "https://connect.facebook.net/en_US/sdk.js";

  @override
  void execute([RdSignal event = null]) {
    super.execute(event);

    var script = new html.ScriptElement();
    script.id = "facebook-jssdk";
    html.document.body.append(script);
    script.onLoad.first.then((loadEvent) {
      _handleSDKLoaded();
    });
    script.onError.first.then((errorEvent) {
      dispatchCompleteEvent('Failed to load Facebook library.');
    });
    script.src = facebookSDKUrl;
  }

  void _handleSDKLoaded() {
    _fbModel.FB = js.context["FB"];

    js.JsObject initConfig = new js.JsObject.jsify({
      "appId": getProperty("project.facebook.appid"),
      "cookie": true,
      "xfbml": false,
      "version": 'v2.1',
    });

    _fbModel.FB.callMethod("init", [initConfig]);
    _fbModel.FB.callMethod("getLoginStatus", [_handleResult]);
  }

  void _handleResult(js.JsObject response) {
    if (containsError(response)) return;

    if (response["authResponse"] != null) {
      _fbModel.accessToken = response["authResponse"]["accessToken"];
      _fbModel.userIsAuthenticated = true;
      _fbModel.user = new FBUserVO()..uid = response["authResponse"]["userID"];

      new RdSignal(FBEvents.USER_GETINFO_PERMISSIONS, null, _onPermissions).dispatch();
    } else {
      dispatchCompleteEvent();
    }
  }

  void _onPermissions([List perms = null]) {
    dispatchCompleteEvent();
  }
}
