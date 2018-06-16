part of acanvas_framework.facebook;

class FBLogoutBrowserCommand extends AbstractFBCommand {
  @override
  void execute([AcSignal event = null]) {
    super.execute(event);

    _fbModel.FB.callMethod("logout", [_handleResult]);
  }

  void _handleResult(js.JsArray response) {
    if (containsError(response)) return;

    _fbModel.userIsAuthenticated = false;
    _fbModel.user = null;
    _fbModel.userAlbumPhotos = [];
    _fbModel.userAlbums = [];

    dispatchCompleteEvent();
  }
}
