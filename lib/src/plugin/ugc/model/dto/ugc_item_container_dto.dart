part of stagexl_rockdot.ugc;

/**
 * @author nilsdoehring
 */
class UGCItemContainerDTO implements IXLDTO {
  int id;
  int parent_container_id;
  int privacy_level;

  String creator_uid;

  // assembled in AMF Endpoint via uid relation
  UGCUserDTO creator;
  String title;
  String description;
  num like_count = 0;
  int complain_count = 0;
  int flag = 0;

  // 0: not blocked, 1: blocked
  // calculated extras (calculated in SQL query)
  int rowindex;
  String totalrows;

  // (assembled in AMF Endpoint via container_id relation in itemcontainer_roles table)
  List<UGCItemContainerRoleDTO> roles = [];

  // (assembled in AMF Endpoint via container_id relation in items table)
  List<UGCItemDTO> items = [];

  // (assembled in AMF Endpoint via task_id relation in itemcontainer_tasks crosstable)
  UGCTaskDTO task;


  UGCItemContainerDTO([Map inputDTO = null]) {
    if (inputDTO != null) {
      id = inputDTO["id"];
      parent_container_id = inputDTO["parent_container_id"];
      privacy_level = inputDTO["privacy_level"];
      creator_uid = inputDTO["creator_uid"];
      title = inputDTO["title"];
      description = inputDTO["description"];
      like_count = inputDTO["like_count"];
      complain_count = inputDTO["complain_count"];
      flag = inputDTO["flag"];
      rowindex = inputDTO["rowindex"];
      totalrows = inputDTO["totalrows"];

      for (int i = 0; i < inputDTO["roles"].length; i++) {
        inputDTO["roles"][i] = new UGCItemContainerRoleDTO(inputDTO["roles"][i]);
      }
      roles = inputDTO["roles"];

      for (int i = 0; i < inputDTO["items"].length; i++) {
        inputDTO["items"][i] = new UGCItemDTO(inputDTO["items"][i]);
      }
      items = inputDTO["items"];

      creator = new UGCUserDTO(inputDTO["creator"]);
      task = new UGCTaskDTO(inputDTO["task"]);
    }
  }

  @override
  Map toJson() {

    List<Map> rolesMaps = [];
    roles.forEach((r) {
      rolesMaps.add(r.toJson());
    });

    List<Map> itemsMaps = [];
    items.forEach((r) {
      itemsMaps.add(r.toJson());
    });

    return {
      "id": id,
      "parent_container_id": parent_container_id,
      "privacy_level": privacy_level,
      "creator_uid": creator_uid,
      "title": title,
      "description": description,
      "like_count": like_count,
      "flag": flag,
      "rowindex": rowindex,
      "complain_count": complain_count,
      "totalrows": totalrows,

      "roles": rolesMaps,

      "items": itemsMaps,

      "creator": creator.toJson(),
      "task": task.toJson()
    };
  }

}
