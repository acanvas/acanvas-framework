part of stagexl_rockdot;

@retain
class FBPhotoUploadCommand extends AbstractFBCommand {

  @override
  void execute([RockdotEvent event = null]) {
    super.execute(event);

    VOFBPhotoUpload vo = event.data;

    js.JsObject queryConfig = new js.JsObject.jsify({
      "image": vo.bmp,
      "message": vo.caption,
      "fileName": vo.fileName
    });
    _fbModel.FB.callMethod("api", [vo.location, "post", queryConfig, _handleResult]);
  }

  void _handleResult(js.JsObject response) {
//      hideMessage("notification.facebook.loading");
    if (containsError(response)) return;
    dispatchCompleteEvent();
  }
}
