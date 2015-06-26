part of stagexl_rockdot.facebook;


//@retain
class FBUserGetInfoPermissionsCommand extends AbstractFBCommand {

  @override
  void execute([XLSignal event = null]) {
    super.execute(event);
    
    if (notLoggedIn(event)) return;

    js.JsObject queryConfig = new js.JsObject.jsify({});
    _fbModel.FB.callMethod("api", ["/me/permissions", "get", queryConfig, _handleResult]);

  }

  void _handleResult(js.JsObject response, [js.JsObject fail = null]) {
    if(containsError(response)) return;

    List perms = [];
    response["data"].forEach((e) {
      if (e["status"] == "granted") perms.add(e["permission"]);
    });

    _fbModel.userPermissions = perms;

    dispatchCompleteEvent();
  }
}
