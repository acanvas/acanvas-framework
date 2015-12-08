part of stagexl_rockdot.google;

//@retain
class GooglePlusMomentsGetCommand extends AbstractGoogleCommand {

  @override
  void execute([RdSignal event = null]) {
    super.execute(event);

    if (notLoggedIn(event)) return;

    String id = "me";
    if (event.data != null && event.data is String) {
      id = event.data;
    }

    new PlusApi(_gModel.client).moments.list(id, "vault").then(_handleResult, onError: dispatchErrorEvent);

    showMessage(getProperty(getProperty("message.google.loading.data")));
  }

  void _handleResult(MomentsFeed moments) {
    hideMessage();

    _gModel.moments = moments;
    dispatchCompleteEvent(moments.items);
  }
}
