part of rockdot_framework.google;

/*
 * https://developers.google.com/+/web/share/interactive#rendering_the_button_with_javascript
 */

class GooglePlusShareRenderCommand extends AbstractGoogleCommand {
  String GapiUrl = "https://apis.google.com/js/client:platform.js";
  String recipients = "";

  @override
  void execute([RdSignal event = null]) {
    super.execute(event);

    js.context['dartGapiPlusLoaded'] = () {
      _handleLoaded();
    };

    var script = new html.ScriptElement();
    script.src = '${GapiUrl}?onload=dartGapiPlusLoaded';
    script.onError.first.then((errorEvent) {
      dispatchErrorEvent('Failed to load gapi library.');
    });
    html.document.body.append(script);

    if (event.data != null) {
      recipients = event.data.join(",");
    }
  }

  void _handleLoaded() {
    js.JsObject gapi = js.context["gapi"];

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

    gapi["interactivepost"].callMethod("render", ["plus-button", initConfig]);

    html.Element el = html.querySelector("#plus-button-holder");
    HtmlObject obj = new HtmlObject(el);
    RdConstants.getStage().addChild(obj);
    obj.x = html.window.innerWidth / 2 - obj.width / 2;
    obj.y = html.window.innerHeight / 2 - obj.height / 2;
    obj.visible = true;

    dispatchCompleteEvent();
  }
}
