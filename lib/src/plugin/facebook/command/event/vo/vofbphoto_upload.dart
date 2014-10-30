part of stagexl_rockdot;

class VOFBPhotoUpload {

  Bitmap bmp;
  String url;
  String message;
  String place;
  bool no_story;

  String fileName;
  String album_id;

  VOFBPhotoUpload({this.fileName, this.album_id, this.bmp, this.place, this.message, this.url, this.no_story : true}) {
  }

}
