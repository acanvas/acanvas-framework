part of stagexl_rockdot.io;

class IOImageUploadVO implements IXLVO {

  String targetUrl;
  String fileName;
  BitmapData bmd;

  IOImageUploadVO(this.fileName, this.bmd, this.targetUrl) {
  }

}
