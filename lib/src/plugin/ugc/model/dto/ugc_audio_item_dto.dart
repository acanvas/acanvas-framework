part of stagexl_rockdot;

class UGCAudioItemDTO implements IXLDTO {
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
    return {
      "id": id,
      "url": url,
      "length": length
    };
  }
}
