part of stagexl_rockdot;

@retain
class FBPhotoGetFromAlbumCommand extends AbstractFBCommand {

  DataRetrieveVO _vo;

  @override
  void execute([XLSignal event = null]) {
    super.execute(event);
    showMessage(getProperty("message.facebook.loading.data"));
    
    String id = "me";
    if (event.data != null) {
      if(event.data is String){
        id = event.data;
      }
      if(event.data is DataRetrieveVO){
        _vo = event.data;
        id = _vo.id;
      }
    }

    js.JsObject queryConfig = new js.JsObject.jsify({});
    _fbModel.FB.callMethod("api", ["/$id/photos", "get", queryConfig, _handleResult]);
  }

  void _handleResult(js.JsObject response) {
    hideMessage();
    if (containsError(response)) return;

    List photos = [];
    response["data"].forEach((e) {
      photos.add(new FBPhotoVO(e));
    });

    _fbModel.userAlbumPhotos = photos;
    _fbModel.userAlbumPhotos[0].totalrows = photos.length;

    if(_vo != null){
      _vo.nextToken = response["paging"]["cursors"]["after"];
      _vo.totalSize = photos.length;
    }

    dispatchCompleteEvent(_fbModel.userAlbumPhotos);
  }


}
