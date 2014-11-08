part of stagexl_rockdot;

@retain
class GooglePlusPeopleGetCommand extends AbstractGoogleCommand {

  @override
  void execute([XLSignal event = null]) {
    super.execute(event);
//			dispatchMessage("notification.facebook.loading");

    String id = "me";
    if (event.data != null && event.data is String) {
      id = event.data;
    }

    new PlusApi(_gModel.client).people.list(id, "visible").then(_handleResult).catchError(dispatchErrorEvent);
    
    showMessage(getProperty("message.google.loading.data"));
  }

  void _handleResult(PeopleFeed circles) {
    hideMessage();
    _gModel.circles = circles;
    dispatchCompleteEvent();
  }
}
