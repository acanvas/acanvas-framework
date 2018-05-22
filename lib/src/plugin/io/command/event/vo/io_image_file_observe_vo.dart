part of rockdot_framework.io;

class IOImageFileObserveVO implements IRdVO {
  String filetypePattern;
  double scaleImage;
  DisplayObject watermark;
  double scaleWatermark;

  IOImageFileObserveVO(
      [this.filetypePattern = r"(jpeg|png)",
      this.scaleImage = 1.0,
      this.watermark,
      this.scaleWatermark = 1.0]) {}
}
