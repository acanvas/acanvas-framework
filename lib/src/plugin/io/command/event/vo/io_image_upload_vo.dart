part of stagexl_rockdot.io;

class IOImageUploadVO implements IRdVO {

  String targetUrl;
  String fileName;
  BitmapData bmd;

  IOImageUploadVO(this.fileName, this.bmd, this.targetUrl) {
  }

}
