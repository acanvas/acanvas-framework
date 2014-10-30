part of stagexl_rockdot;

@retain
class AbstractFBCommand extends CoreCommand implements IFBModelAware {
  FBModel _fbModel;
  void set fbModel(FBModel fbModel) {
    _fbModel = fbModel;
  }

  bool containsError(js.JsObject response) {
    if (response["error"] != null) {
      this.log.debug("FB Init did not produce a valid access token: {1} (code: {2}, type: {3})", [response["error"]["message"], response["error"]["code"], response["error"]["type"]]);
      dispatchErrorEvent(response["error"]);
      return true;
    } else {
      return false;
    }
  }
}
