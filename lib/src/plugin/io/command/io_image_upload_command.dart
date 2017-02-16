part of rockdot_framework.io;

class IOImageUploadCommand extends RdCommand {
  @override
  void execute([RdSignal event = null]) {
    super.execute(event);

    IOImageUploadVO vo = event.data;

    //Convert target BitmapData to Blob
    String url = vo.bmd.toDataUrl("image/jpeg", 0.95);
    html.Blob blob = createImageBlob(url);

    //TODO upload big and thumbnail?
    //Add target BitmapData to Multipart Form
    html.FormData formData = new html.FormData();
    formData.appendBlob("Filedata", blob, vo.fileName);

    //Send to Server
    sendData(vo.targetUrl, formData);
  }

  void sendData(String url, html.FormData formData) {
    html.HttpRequest req = new html.HttpRequest();
    req.onReadyStateChange.listen((html.ProgressEvent e) {
      if (req.readyState == html.HttpRequest.DONE) {
        if (req.status == 200 || req.status == 0) {
          dispatchCompleteEvent();
        } else {
          dispatchErrorEvent();
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
}
