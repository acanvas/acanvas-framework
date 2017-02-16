part of rockdot_framework.ugc;

class UGCItemDTO implements IRdDTO {
  static const TYPE_TEXT = 0;
  static const TYPE_IMAGE = 1;
  static const TYPE_VIDEO = 2;
  static const TYPE_AUDIO = 3;
  static const TYPE_LINK = 4;
  int id;
  int container_id;
  String creator_uid;

  // assembled in AMF Endpoint via uid relation
  UGCUserDTO creator;
  String title;

  String description;
  int like_count = 0;
  int complain_count = 0;
  int flag = 0;

  // 0: not blocked, 1: blocked
  String timestamp;
  int type;

  // 0:text, 1:image, 2:video, 3:audio, 4:link
  int type_id;

  // assembled in AMF Endpoint via type_id relation
  IRdDTO type_dao;

  // assembled in AMF Endpoint by counting array index
  int rowindex;

  // assembled in AMF Endpoint via supersmart extra query
  int totalrows;

  // optionally loaded via command
  List<UGCUserDTO> likers;

  UGCItemDTO([Map inputDTO = null]) {
    if (inputDTO != null) {
      id = inputDTO["id"];
      creator_uid = inputDTO["creator_uid"];
      title = inputDTO["title"];
      description = inputDTO["description"];
      like_count = inputDTO["like_count"];
      complain_count = inputDTO["complain_count"];
      flag = inputDTO["flag"];
      timestamp = inputDTO["timestamp"];
      type = inputDTO["type"];
      type_id = inputDTO["type_id"];
      rowindex = inputDTO["rowindex"];
      totalrows = inputDTO["totalrows"];

      if (type_id != null) {
        switch (type) {
          case 0:
            type_dao = new UGCTextItemDTO(inputDTO);
            break;
          case 1:
            type_dao = new UGCImageItemDTO(inputDTO);
            break;
          case 2:
            type_dao = new UGCVideoItemDTO(inputDTO);
            break;
          case 3:
            type_dao = new UGCAudioItemDTO(inputDTO);
            break;
          case 4:
            // type_dao = obj;
            break;
        }
      }
      type_dao = inputDTO["type_dao"];

      if (inputDTO["likers"] != null) {
        for (int i = 0; i < inputDTO["likers"].length; i++) {
          inputDTO["likers"][i] = new UGCItemContainerRoleDTO(inputDTO["likers"][i]);
        }
      }
      likers = inputDTO["likers"];

      creator = new UGCUserDTO(inputDTO["creator"]);
    }
  }

  @override
  Map toJson() {
    List<Map> likersMaps = [];
    likers.forEach((r) {
      likersMaps.add(r.toJson());
    });

    return {
      "id": id,
      "creator_uid": creator_uid,
      "title": title,
      "description": description,
      "like_count": like_count,
      "flag": flag,
      "timestamp": timestamp,
      "type": type,
      "type_id": type_id,
      "rowindex": rowindex,
      "complain_count": complain_count,
      "totalrows": totalrows,
      "likers": likersMaps,
      "type_dao": type_dao.toJson(),
      "creator": creator.toJson(),
    };
  }
}
