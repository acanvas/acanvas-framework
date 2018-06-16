part of acanvas_framework.io;

class IOImageUploadVO implements IAcVO {
  String targetUrl;
  String fileName;
  BitmapData bmd;

  IOImageUploadVO(this.fileName, this.bmd, this.targetUrl) {}
}
