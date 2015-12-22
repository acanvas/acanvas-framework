part of rockdot_framework.facebook;

class FBAlbumVO {

  bool can_upload;

  String id;
  int count;
  String cover_photo;
  String name;
  String link;

  String from_id;
  String from_name;
  String privacy;
  String type;
  String created_time;
  String updated_time;

  int totalrows;

  //internal

  FBAlbumVO([dynamic obj = null]) {
    if (obj != null) {
      id = obj["id"];
      can_upload = obj["can_upload"];
      name = obj["name"];
      from_id = obj["from"]["id"];
      from_name = obj["from"]["name"];
      type = obj["type"];
      cover_photo = obj["cover_photo"];
      link = obj["link"];
      privacy = obj["privacy"];
      count = obj["count"];
      created_time = obj["created_time"];
      updated_time = obj["updated_time"];
    }
  }
}
