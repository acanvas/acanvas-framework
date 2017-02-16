part of rockdot_framework.ugc;

class UGCImageItemDTO implements IRdDTO {
  int id;
  int w;
  int h;
  String url_big;
  String url_thumb;
  String timestamp;

  UGCImageItemDTO([Map inputDTO = null]) {
    if (inputDTO != null) {
      id = inputDTO["id"];
      w = inputDTO["w"];
      h = inputDTO["h"];
      url_big = inputDTO["url_big"];
      url_thumb = inputDTO["url_thumb"];
      timestamp = inputDTO["timestamp"];
    }
  }

  @override
  Map toJson() {
    return {"id": id, "w": w, "h": h, "url_big": url_big, "url_thumb": url_thumb, "timestamp": timestamp};
  }
}
