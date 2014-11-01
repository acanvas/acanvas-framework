part of stagexl_rockdot;

@retain
class FBInitBrowserCommand extends AbstractFBCommand {

  @override
  void execute([XLSignal event = null]) {
    super.execute(event);

    if (RockdotConstants.LOCAL) {
      
      this.log.debug("Facebook Not Supported here.");
      dispatchCompleteEvent();
      
    } else {

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
  }

  void _handleResult(js.JsObject response) {
    if(containsError(response)) return;
    
    if (response["authResponse"] != null) {
      
      _fbModel.accessToken = response["authResponse"]["accessToken"];
      _fbModel.userIsAuthenticated = true;
      _fbModel.user = new FBUserVO()
                        ..uid = response["authResponse"]["userID"];

     new XLSignal(FBEvents.USER_GETINFO_PERMISSIONS, null, _onPermissions).dispatch();
    }
    
  }

  void _onPermissions(List perms) {
    dispatchCompleteEvent();
  }
}
