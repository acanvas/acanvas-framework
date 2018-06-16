part of acanvas_framework.babylon;

class BabylonInitBrowserCommand extends AcCommand {
  String babylonJSUrl =
      "https://cdnjs.cloudflare.com/ajax/libs/babylonjs/2.3.0/babylon.js";

  @override
  void execute([AcSignal event = null]) {
    super.execute(event);

    var script = new html.ScriptElement();
    script.id = "babylon-js";
    html.document.body.append(script);
    script.onLoad.first.then((loadEvent) {
      dispatchCompleteEvent();
    });
    script.onError.first.then((errorEvent) {
      dispatchCompleteEvent('Failed to load Babylon JS library.');
    });
    script.src = babylonJSUrl;
  }
}
