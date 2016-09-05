part of rockdot_framework.babylon;

//@retain
class BabylonInitBrowserCommand extends RdCommand {

  String babylonJSUrl = "https://cdnjs.cloudflare.com/ajax/libs/babylonjs/2.3.0/babylon.js";

  @override
  void execute([RdSignal event = null]) {
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
