part of stagexl_rockdot;

class UGCVideoItemDTO implements IXLDTO {
  int id;
  int w;
  int h;
  int length;

  String url_big;
  String url_thumb;
  String timestamp;
  
  UGCVideoItemDTO([Map inputDTO = null]) {
    if (inputDTO != null) {
      id = inputDTO["id"];
      w = inputDTO["w"];
      h = inputDTO["h"];
      length = inputDTO["length"];
      url_big = inputDTO["url_big"];
      url_thumb = inputDTO["url_thumb"];
      timestamp = inputDTO["timestamp"];
    }
  }

  @override
  Map toJson() {
    return {
      "id": id,
      "w": w,
      "h": h,
      "length": length,
      "url_big": url_big,
      "url_thumb": url_thumb,
      "timestamp": timestamp
    };
  }
}
