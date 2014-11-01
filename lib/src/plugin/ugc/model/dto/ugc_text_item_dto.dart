part of stagexl_rockdot;

class UGCTextItemDTO implements IXLDTO {
  int id;
  String text;

  UGCTextItemDTO([Map inputDTO = null]) {
    if (inputDTO != null) {
      id = inputDTO["id"];
      text = inputDTO["text"];
    }
  }

  @override
  Map toJson() {
    return {
      "id": id,
      "text": text
    };
  }
}
