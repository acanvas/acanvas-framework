part of rockdot_framework.io;

class IOFileSelectObserveCommand extends RdCommand {
  IOImageFileObserveVO _vo;

  @override
  void execute([RdSignal event = null]) {
    super.execute(event);

    _vo = event.data;

    observeFileInput();
  }

  void observeFileInput() {
    html.InputElement fileElement = html.querySelector(IOModel.FILE_ELEMENT);
    if(fileElement == null){
      dispatchErrorEvent("HTML FileElement doesn't exist.");
    }
    fileElement.onChange.listen((e) => processFiles(fileElement.files));
  }


void processFiles(List<html.File> files) {
  for (html.File file in files) {
    if(processFile(file)){
      return;
    };
  }
}

bool processFile(html.File file) {

  if (!isFileTypeCorrect(file)) {
    log.info("Oops, that wasn't an image, can you try an image?");
    return false;
  }

  readIn(file);
  return true;
}

bool isFileTypeCorrect(html.File file) {
  Pattern pattern = new RegExp(_vo.filetypePattern);
  return file.type.toString().contains(pattern);
}

void readIn(html.File file) {
  html.FileReader reader = new html.FileReader();
  reader.onLoadEnd.listen((e) => createImageElement(reader.result));
  reader.readAsDataUrl(file);
}

void createImageElement(String base64) {
  // set the image data and wait for image onload to fire
  html.ImageElement originalImg = new html.ImageElement(); //querySelector("#originImg");
  originalImg.onLoad.listen((e) => scale(originalImg));
  originalImg.src = base64;
}

void scale(html.ImageElement imageElement) {
  //Create BitmapData from ImageElement
  BitmapData sourceBitmapData = new BitmapData.fromImageElement(imageElement /*, 1/SCALE*/);

  //Scaling (TODO calculate scale according to image dimensions)
  int targetWidth = (sourceBitmapData.width * _vo.scaleImage).ceil();
  int targetHeight = (sourceBitmapData.height * _vo.scaleImage).ceil();

  //Draw source BitmapData (scaled) to target
  BitmapData targetBitmapData = new BitmapData(targetWidth, targetHeight);
  targetBitmapData.draw(sourceBitmapData, new Matrix(_vo.scaleImage, 0, 0, _vo.scaleImage, 0, 0));

  if(_vo.watermark != null){
    //Draw logo BitmapData (scaled) to target
    DisplayObject logo = _vo.watermark;
    num tx = targetWidth / 2 - logo.width / 2 * _vo.scaleWatermark;
    num ty = targetHeight / 2 - logo.height / 2 * _vo.scaleWatermark;
    targetBitmapData.draw(logo, new Matrix(_vo.scaleWatermark, 0, 0, _vo.scaleWatermark, tx, ty));
  }

  dispatchCompleteEvent(targetBitmapData);

}
}
