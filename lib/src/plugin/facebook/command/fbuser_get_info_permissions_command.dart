part of stagexl_rockdot;


@retain
class FBUserGetInfoPermissionsCommand extends AbstractFBCommand {

  @override
  void execute([XLSignal event = null]) {
    super.execute(event);
//			dispatchMessage("loading.facebook.login");

    js.JsObject queryConfig = new js.JsObject.jsify({});
    _fbModel.FB.callMethod("api", ["/me/permissions", "get", queryConfig, _handleResult]);

  }

  void _handleResult(js.JsObject response, [js.JsObject fail = null]) {
//			hideMessage("notification.facebook.loading")
    if(containsError(response)) return;

    List perms = [];
    response["data"].forEach((e) {
      if (e["status"] == "granted") perms.add(e["permission"]);
    });

    _fbModel.userPermissions = perms;

    dispatchCompleteEvent();
  }
}
