part of acanvas_framework.ugc;

class UGCAudioItemDTO implements IAcDTO {
  int id;
  String url;
  int length;

  UGCAudioItemDTO([Map inputDTO = null]) {
    if (inputDTO != null) {
      id = inputDTO["id"];
      url = inputDTO["url"];
      length = inputDTO["length"];
    }
  }

  @override
  Map toJson() {
    return {"id": id, "url": url, "length": length};
  }
}
