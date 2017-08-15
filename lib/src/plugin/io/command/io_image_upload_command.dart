part of rockdot_framework.io;

class IOImageUploadCommand extends RdCommand {
  @override
  void execute([RdSignal event = null]) {
    super.execute(event);

    IOImageUploadVO vo = event.data;

    //Create Multipart Form
    html.FormData formData = new html.FormData();

    //Convert target BitmapData to Blob
    html.Blob blob = createImageBlob( vo.bmd.toDataUrl("image/jpeg", 0.95) );

    //Convert target BitmapData to Blob (Thumbnail)
    Bitmap b = new Bitmap(vo.bmd.clone());
    b.width = 120;
    b.height = 120;

    BitmapData thumb = new BitmapData(120, 120);
    thumb.draw(b);
    b.bitmapData.clear();
    html.Blob blobThumb = createImageBlob( thumb.toDataUrl("image/jpeg", 0.95) );

    formData.appendBlob("Filedata", blob, "${vo.fileName}.jpg");
    formData.appendBlob("Filedata", blobThumb, "${vo.fileName}_thumb.jpg");

    //Send to Server
    sendData(vo.targetUrl, formData);
  }

  void sendData(String url, html.FormData formData) {
    html.HttpRequest req = new html.HttpRequest();
    req.onReadyStateChange.listen((_) {
      if (req.readyState == html.HttpRequest.DONE) {
        if (req.status == 200 || req.status == 0) {
          dispatchCompleteEvent();
        } else {
          dispatchErrorEvent(req.responseText);
        }
      }
    });
    req.open("POST", url, async: true);
    req.send(formData);
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


  /**
   * @see http://stackoverflow.com/questions/22196593/make-picture-from-base64-on-client-side
   *
    Blob createImageBlobNotWorking(String dataUri) {
    List bl = (CryptoUtils.base64StringToBytes(dataUri.split(",")[1]));
    String mimeString = dataUri.split(',')[0].split(':')[1].split(';')[0];
    Uint8ClampedList base64Data = new Uint8ClampedList.fromList(bl);

    //convert to blob
    String jpg = new String.fromCharCodes(base64Data);
    Blob blob = new Blob([jpg], mimeString);
    return blob;
  }
   */
}
