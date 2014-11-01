part of rockdot_nikon;

/**
 * @author nilsdoehring
 * parts taken from @see https://code.google.com/p/dart-examples/source/browse/examples/DartExamples/ImageScaling/ImageScaling.dart
 */

@retain
class PhotoImportFile extends AbstractLayer {

  final double SCALE_IMAGE = .5;
  final double SCALE_LOGO = .75;

  YellowButton _buttonClose;
  Copy _copy;
  ComponentBitmapData _pic;

  PhotoImportFile(String id) : super(id) {
  }

  @override void init([dynamic data = null]) {
    super.init(data);

    _headline.text = getProperty("headline").toUpperCase();

    // copy
    _copy = new Copy(getProperty("copy"), 18, Colors.GREY_MIDDLE);// + _appModel.currentUGCItem.timestamp, 11, Colors.GREY);
    addChild(_copy);

    //_pic = new ComponentImageLoader((_appModel.currentUGCItem.type_dao as UGCImageItemVO).url_big, AbstractLayer.LAYER_WIDTH_MAX, AbstractLayer.LAYER_WIDTH_MAX);
    //addChild(_pic);

    observeFileInput();

    _buttonClose = new YellowButton(getProperty("button.back"));
    _buttonClose.submitEvent = new XLSignal(StateEvents.STATE_VO_BACK);
    addChild(_buttonClose);

    didInit();
  }

  @override void redraw() {

    num w = widthAsSet - 2 * BootstrapConstants.SPACER;

    _kamera.visible = false;
    _headlineY = 60;

    //text
    _headline.x = BootstrapConstants.SPACER;
    _headline.y = _headlineY;
    _headline.width = w;

    _copy.x = BootstrapConstants.SPACER;
    _copy.y = _headlineY + _headline.textHeight + BootstrapConstants.SPACER;
    _copy.width = w;

    if (_pic != null) {
      _pic.y = _copy.y + _copy.textHeight + BootstrapConstants.SPACER;
      _buttonClose.y = _pic.y + _pic.height;
    } else {
      _buttonClose.y = _copy.y + _copy.textHeight;
    }
    _buttonClose.setSize(widthAsSet, BootstrapConstants.HEIGHT_RASTER);

    LAYER_HEIGHT = (_buttonClose.y + _buttonClose.heightAsSet).round();
    
    super.redraw();

    if (_pic != null) {
     // _pic.x = -_pic.width / 2;
    }
  }

  void observeFileInput() {
    InputElement fileElement = querySelector("#file");
    fileElement.onChange.listen((e) => processFiles(fileElement.files));
  }

  void processFiles(List<File> files) {
    for (File file in files) {
      processFile(file);
    }
  }

  void processFile(File file) {
    print("file.name=${file.name}");

    if (!isAnImage(file)) {
      window.alert("Oops, that wasn't an image, can you try an image?");
      return;
    }

    readIn(file);
  }

  bool isAnImage(File file) {
    print("file.type=${file.type}");
    Pattern pattern = new RegExp(r"(jpeg|png)");
    return file.type.toString().contains(pattern);
  }

  void readIn(File file) {
    FileReader reader = new FileReader();
    reader.onLoadEnd.listen((e) => createImageElement(reader.result));
    reader.readAsDataUrl(file);
  }

  void createImageElement(String base64) {
    print("from file: " + base64);
    // set the image data and wait for image onload to fire
    ImageElement originalImg = new ImageElement(); //querySelector("#originImg");
    originalImg.onLoad.listen((e) => scale(originalImg));
    originalImg.src = base64;
  }

  void scale(ImageElement imageElement) {
    //Create BitmapData from ImageElement
    BitmapData sourceBitmapData = new BitmapData.fromImageElement(imageElement/*, 1/SCALE*/);

    //Scaling (TODO calculate scale according to image dimensions)
    int targetWidth = (sourceBitmapData.width * SCALE_IMAGE).ceil();
    int targetHeight = (sourceBitmapData.height * SCALE_IMAGE).ceil();
    
    //Draw source BitmapData (scaled) to target
    BitmapData targetBitmapData = new BitmapData(targetWidth, targetHeight);
    targetBitmapData.draw(sourceBitmapData, new Matrix(SCALE_IMAGE, 0, 0, SCALE_IMAGE, 0, 0));
    
    //Draw logo BitmapData (scaled) to target
    IAMLogo logo = new IAMLogo(getProperty("element.header.logo.text", true));
    num tx = targetWidth/2 - logo.width/2 * SCALE_LOGO;
    num ty = targetHeight/2 - logo.height/2 * SCALE_LOGO;
    targetBitmapData.draw(logo, new Matrix(SCALE_LOGO, 0, 0, SCALE_LOGO, tx, ty));
    
    //Create Bitmap from target BitmapData and add to Stage
    _pic = new ComponentBitmapData(targetBitmapData);
    addChild(_pic);
    _pic.setSize(widthAsSet, 400);
    redraw();

    //Convert target BitmapData to Blob (TODO revoke url after upload)
    String url = targetBitmapData.toDataUrl("image/jpeg", 0.95);
    Blob blob = createImageBlob(url);

    //Add target BitmapData dataurl to DOM (just to see if all is peachy)
    //ImageElement img = querySelector("#originImg");
    //img.src = Url.createObjectUrlFromBlob(blob);
    
    //Add target BitmapData to Multipart Form
    FormData formData = new FormData();
    formData.appendBlob("Filedata", blob, "test.jpg");

    //Send to Server
    sendData(formData);
  }

  void sendData(dynamic data) {

    final req = new HttpRequest();
    req.onReadyStateChange.listen((ProgressEvent e) {
      if (req.readyState == HttpRequest.DONE && (req.status == 200 || req.status == 0)) {
        window.alert("upload complete");
      }
    });
    //req.open("POST", "http://www.local.com:8888/upload");
      req.open("POST", "http://rockdot.sounddesignz.com/upload");
    req.send(data);
  }

  /**
   * @see https://chromium.googlesource.com/external/dart/bleeding_edge/+/master/dart/tests/html/url_test.dart
   */
  Blob createImageBlob(String dataUri) {
    String byteString = window.atob(dataUri.split(',')[1]);
    String mimeString = dataUri.split(',')[0].split(':')[1].split(';')[0];
    Uint8List arrayBuffer = new Uint8List(byteString.length);
    Uint8List dataArray = new Uint8List.view(arrayBuffer.buffer);
    for (var i = 0; i < byteString.length; i++) {
      dataArray[i] = byteString.codeUnitAt(i);
    }
    Blob blob = new Blob([arrayBuffer], mimeString);
    return blob;
  }
  
  /**
   * @see http://stackoverflow.com/questions/22196593/make-picture-from-base64-on-client-side
   */
  Blob createImageBlobNotWorking(String dataUri) {
    List bl = (CryptoUtils.base64StringToBytes(dataUri.split(",")[1]));
    String mimeString = dataUri.split(',')[0].split(':')[1].split(';')[0];
    Uint8ClampedList base64Data = new Uint8ClampedList.fromList(bl);

    //convert to blob
    String jpg = new String.fromCharCodes(base64Data);
    Blob blob = new Blob([jpg], mimeString);
    return blob;
  }

}
