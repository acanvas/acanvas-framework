part of rockdot_framework.google;

class AbstractGoogleCommand extends RdCommand implements IGoogleModelAware {
  GoogleModel _gModel;

  void set googleModel(GoogleModel gModel) {
    _gModel = gModel;
  }

  bool notLoggedIn(RdSignal event) {
    if (!_gModel.userIsAuthenticated) {
      //If the Login went successful, execute this Event again.
      new RdSignal(GoogleEvents.USER_LOGIN, null, () {
        execute(event);
      }).dispatch();
      //For now, cancel this Event.
      return true;
    } else {
      //User logged in, all is peachy.
      return false;
    }
  }

  bool containsError(js.JsObject response) {
    if (response["error"] != null) {
      this.log.info(
          "Google Init did not produce a valid access token: {1} (code: {2}, type: {3})",
          [
            response["error"]["message"],
            response["error"]["code"],
            response["error"]["type"]
          ]);
      dispatchErrorEvent(response["error"]);
      return true;
    } else {
      return false;
    }
  }
}
