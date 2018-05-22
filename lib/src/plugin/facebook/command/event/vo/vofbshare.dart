part of rockdot_framework.facebook;

class VOFBShare {
  static const String TYPE_SHARE = "TYPE_SHARE";
  static const String TYPE_SHARE_OG = "TYPE_SHARE_OG";

  String message;
  String image;
  String contentlink;
  String type;

  VOFBShare(this.type,
      [this.message = "", this.contentlink = "", this.image = ""]) {}
}
