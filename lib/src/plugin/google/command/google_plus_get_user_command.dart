part of acanvas_framework.google;

class GooglePlusGetUserCommand extends AbstractGoogleCommand {
  @override
  void execute([AcSignal event = null]) {
    super.execute(event);

    if (notLoggedIn(event)) return;

    String id = "me";
    if (event.data != null && event.data is String) {
      id = event.data;
    }

    new PlusApi(_gModel.client)
        .people
        .get(id)
        .then(_handleResult, onError: dispatchErrorEvent);

    showMessage(getProperty(getProperty("message.google.loading.data")));
  }

  void _handleResult(Person person) {
    hideMessage();
    _gModel.user = person;
    dispatchCompleteEvent(person);
  }
}
