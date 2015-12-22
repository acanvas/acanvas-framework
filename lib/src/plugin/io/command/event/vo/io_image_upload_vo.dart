part of rockdot_framework.io;

class IOImageUploadVO implements IRdVO {

  String targetUrl;
  String fileName;
  BitmapData bmd;

  IOImageUploadVO(this.fileName, this.bmd, this.targetUrl) {
  }

}
