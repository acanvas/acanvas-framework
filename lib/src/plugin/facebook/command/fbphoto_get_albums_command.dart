part of stagexl_rockdot;

@retain
class FBPhotoGetAlbumsCommand extends AbstractFBCommand {

  @override
  void execute([XLSignal event = null]) {
    super.execute(event);
//			dispatchMessage("notification.facebook.loading");

    String uid = _fbModel.user.uid;

    js.JsObject queryConfig = new js.JsObject.jsify({});
    _fbModel.FB.callMethod("api", ["/$uid/albums", "get", queryConfig, _handleResult]);
  }

  void _handleResult(js.JsObject response) {
//			hideMessage("notification.facebook.loading")
    if(containsError(response)) return;
    
    List albums = [];
    response["data"].forEach((e){
      albums.add( new FBAlbumVO(e) );
    });
    
    _fbModel.userAlbums = albums;
    dispatchCompleteEvent(albums);
  }
}
