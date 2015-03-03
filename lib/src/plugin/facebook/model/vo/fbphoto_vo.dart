part of stagexl_rockdot.facebook;

class FBPhotoVO {

  String id;
  String from_id;
  String from_name;
  String name;
  String source;
  num width;
  num height;
  List images;
  String link;
  String icon;
  String created_time;
  String updated_time;
  num position;
  List<FBCommentVO> comments;

  int totalrows; //internal

  FBPhotoVO([dynamic obj = null]) {

    if (obj != null) {
      id = obj["id"];
      name = obj["name"];
      from_id = obj["from"]["id"];
      from_name = obj["from"]["name"];
      source = obj["source"];
      width = obj["width"];
      height = obj["height"];
      link = obj["link"];
      icon = obj["icon"];
      position = obj["position"];
      created_time = obj["created_time"];
      updated_time = obj["updated_time"];

      images = [];
      obj["images"].forEach((e) {
        images.add({
          "width": e["width"],
          "height": e["height"],
          "source": e["source"]
        });
      });

      comments = [];
      if (obj["comments"] != null) {

        obj["comments"]["data"].forEach((e) {
          comments.add(new FBCommentVO(e));
        });
      }
    }
  }
}
