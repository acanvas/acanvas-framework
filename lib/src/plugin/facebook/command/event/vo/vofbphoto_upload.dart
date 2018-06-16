part of acanvas_framework.facebook;

class VOFBPhotoUpload {
  BitmapData bmd;
  String url;
  String message;
  String place;
  bool no_story;

  String fileName;
  String album_id;

  VOFBPhotoUpload(this.fileName, this.album_id,
      {this.bmd, this.place, this.message, this.url, this.no_story: true}) {}
}
