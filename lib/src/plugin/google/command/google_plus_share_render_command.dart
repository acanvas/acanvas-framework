part of stagexl_rockdot;

@retain
class GooglePlusShareRenderCommand extends AbstractGoogleCommand {

  @override
  void execute([XLSignal event = null]) {
    super.execute(event);
    
    String recipients = "";
    if(event.data != null){
      recipients = event.data.join(",");
    }
  
    js.JsObject gapi = js.context["FB"];

    js.JsObject initConfig = new js.JsObject.jsify({
      "clientid": getProperty("project.google.oauth.clientid"),
      "contenturl": getProperty("project.url.content"),
      "contentdeeplinkid": getProperty("project.url.content.deeplink"),
      "cookiepolicy": 'single_host_origin',
      "prefilltext": getProperty("dialog.google.prefill"),
      "calltoactionlabel": getProperty("project.url.cta.label"),
      "calltoactionurl": getProperty("project.url.cta"),
      "calltoactiondeeplinkid": getProperty("project.url.cta.deeplink"),
      "recipients": recipients
    });

    gapi.callMethod("plus-button", [initConfig]);
    
    html.Element el = html.querySelector("#plus-button");
    HtmlObject obj = new HtmlObject(el);
    RockdotConstants.getStage().addChild(obj);

  }

  void _handleLogin(AutoRefreshingAuthClient client) {
    _gModel.client = client;
    _gModel.userScopes = client.credentials.scopes;
    _gModel.accessToken = client.credentials.accessToken.data;
    _gModel.userIsAuthenticated = true;
    dispatchCompleteEvent();
  }
}
