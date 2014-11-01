part of stagexl_rockdot;

@retain
class FBLogoutBrowserCommand extends AbstractFBCommand {
  @override
  void execute([XLSignal event = null]) {
    super.execute(event);

    if (RockdotConstants.LOCAL) {
      this.log.debug("Facebook Not Supported here.");
      RockdotConstants.getStage().juggler.delayCall(dispatchCompleteEvent, .05);

    } else {
      _fbModel.FB.callMethod("logout", [_handleResult]);
    }
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
