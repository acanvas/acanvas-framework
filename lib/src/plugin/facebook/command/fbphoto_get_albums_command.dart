part of stagexl_rockdot.facebook;

//@retain
class FBPhotoGetAlbumsCommand extends AbstractFBCommand {

  @override
  void execute([XLSignal event = null]) {
    super.execute(event);
    
    if (notLoggedIn(event)) return;
    showMessage(getProperty("message.facebook.loading.data"));

    String uid = _fbModel.user.uid;

    js.JsObject queryConfig = new js.JsObject.jsify({});
    _fbModel.FB.callMethod("api", ["/$uid/albums", "get", queryConfig, _handleResult]);
  }

  void _handleResult(js.JsObject response) {
    hideMessage();
    if(containsError(response)) return;
    
    List albums = [];
    response["data"].forEach((e){
      albums.add( new FBAlbumVO(e) );
    });
    
    _fbModel.userAlbums = albums;
    dispatchCompleteEvent(albums);
  }
}
