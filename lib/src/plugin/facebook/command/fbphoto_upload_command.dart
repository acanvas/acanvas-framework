part of rockdot_framework.facebook;


class FBPhotoUploadCommand extends AbstractFBCommand {
  @override
  void execute([RdSignal event = null]) {
    super.execute(event);

    if (notLoggedIn(event)) return;

    VOFBPhotoUpload vo = event.data;

    if (vo.bmd != null) {
      showMessage(getProperty("message.facebook.sending.image"));

      //Convert target BitmapData to Blob (TODO revoke url after upload)
      String mimetype = vo.fileName.contains(new RegExp("jpg|jpeg")) ? "image/jpeg" : "image/png";

      String url = vo.bmd.toDataUrl(mimetype, 0.8);
      html.Blob blob = createImageBlob(url);

      //Add target BitmapData to Multipart Form
      html.FormData formData = new html.FormData();
      formData.appendBlob("source", blob, vo.fileName);
      formData.append("no_story", vo.no_story.toString());

      if (vo.message != null) {
        formData.append("message", vo.message);
      }
      if (vo.place != null) {
        formData.append("place", vo.place);
      }

      sendData("https://graph.facebook.com/${vo.album_id}/photos?access_token=${_fbModel.accessToken}", formData);
    } else if (vo.url != null) {
      Map queryMap = {"no_story": vo.no_story, "url": vo.url};

      if (vo.message != null) {
        queryMap["message"] = vo.message;
      }
      if (vo.place != null) {
        queryMap["place"] = vo.place;
      }

      js.JsObject queryConfig = new js.JsObject.jsify(queryMap);
      _fbModel.FB.callMethod("api", ["/${vo.album_id}/photos", "post", queryConfig, _handleResult]);
    } else {
      dispatchErrorEvent("Neither bmd nor url set in VOFBPhotoUpload.");
    }
  }

  void sendData(String url, html.FormData formData) {
    html.HttpRequest req = new html.HttpRequest();
    req.onReadyStateChange.listen((html.ProgressEvent e) {
      if (req.readyState == html.HttpRequest.DONE && (req.status == 200 || req.status == 0)) {
        dispatchCompleteEvent();
      }
    });
    req.open("POST", url, async: true);
    req.send(formData);
  }

  void _handleResult(js.JsObject response) {
    hideMessage();
    if (containsError(response)) return;
    dispatchCompleteEvent();
  }

  /**
   * @see https://chromium.googlesource.com/external/dart/bleeding_edge/+/master/dart/tests/html/url_test.dart
   */
  html.Blob createImageBlob(String dataUri) {
    String byteString = html.window.atob(dataUri.split(',')[1]);
    String mimeString = dataUri.split(',')[0].split(':')[1].split(';')[0];
    Uint8List arrayBuffer = new Uint8List(byteString.length);
    Uint8List dataArray = new Uint8List.view(arrayBuffer.buffer);
    for (var i = 0; i < byteString.length; i++) {
      dataArray[i] = byteString.codeUnitAt(i);
    }
    html.Blob blob = new html.Blob([arrayBuffer], mimeString);
    return blob;
  }
}
