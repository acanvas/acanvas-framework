part of stagexl_rockdot;

@retain
class FBLoginBrowserCommand extends AbstractFBCommand {

  @override
  void execute([XLSignal event = null]) {
    super.execute(event);

    if (RockdotConstants.LOCAL) {
      this.log.debug("Facebook Not Supported here.");
      dispatchErrorEvent("Facebook Not Supported here.");
    } else {
      if (_fbModel.userIsAuthenticated && event.data == "") {
        dispatchCompleteEvent();
      } else {
        showMessage("message.facebook.login.waiting", blur:true);

        js.JsObject loginConfig = new js.JsObject.jsify({
          "scope": event.data != null ? event.data : "",
          "return_scopes" : true
        });

        _fbModel.FB.callMethod("login", [_handleLogin, loginConfig]);
      }
    }
  }

  void _handleLogin(js.JsObject response, [js.JsObject fail = null]) {
    if(containsError(response)) return;
    
    if (response["authResponse"] != null) {
      
      _fbModel.accessToken = response["authResponse"]["accessToken"];
      _fbModel.userIsAuthenticated = true;
      _fbModel.user = new FBUserVO()
                        ..uid = response["authResponse"]["userID"];
      
      if(response["authResponse"]["grantedScopes"] != null){
        _fbModel.userPermissions = response["authResponse"]["grantedScopes"].split(",");
        //TODO check if the requested permissions have been granted (because user could have clicked "not now")
      }
      
      dispatchCompleteEvent(response["authResponse"]);
    } else {
      this.log.debug("Received empty callback");
      dispatchErrorEvent();
    }
  }
}
