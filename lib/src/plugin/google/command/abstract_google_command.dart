part of stagexl_rockdot;

@retain
class AbstractGoogleCommand extends CoreCommand implements IGoogleModelAware {
  GoogleModel _gModel;
  void set googleModel(GoogleModel gModel) {
    _gModel = gModel;
  }

  bool containsError(js.JsObject response) {
    if (response["error"] != null) {
      this.log.debug("Google Init did not produce a valid access token: {1} (code: {2}, type: {3})", [response["error"]["message"], response["error"]["code"], response["error"]["type"]]);
      dispatchErrorEvent(response["error"]);
      return true;
    } else {
      return false;
    }
  }
}
