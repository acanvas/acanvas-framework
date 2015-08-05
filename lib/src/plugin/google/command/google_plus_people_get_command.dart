part of stagexl_rockdot.google;

//@retain
class GooglePlusPeopleGetCommand extends AbstractGoogleCommand {

  DataRetrieveVO _vo;

  @override
  void execute([XLSignal event = null]) {
    super.execute(event);

    if (notLoggedIn(event)) return;

    String id = "me";
    if (event.data != null) {
      if (event.data is String) {
        id = event.data;
      }
      if (event.data is DataRetrieveVO) {
        _vo = event.data;
      }
    }

    String nextToken = (_vo != null) ? _vo.nextToken : null;

    new PlusApi(_gModel.client).people.list(id, "visible", pageToken: nextToken).then(_handleResult, onError: dispatchErrorEvent);

    showMessage(getProperty("message.google.loading.data"));
  }

  void _handleResult(PeopleFeed circles) {
    hideMessage();
    _gModel.circles = circles;
    if (_vo != null) {
      _vo.nextToken = circles.nextPageToken;
      _vo.totalSize = circles.totalItems;
    }
    dispatchCompleteEvent(circles.items);
  }
}
