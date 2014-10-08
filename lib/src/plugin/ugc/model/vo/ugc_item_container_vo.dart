part of stagexl_rockdot;

/**
	 * @author nilsdoehring
	 */
class UGCItemContainerVO extends RockdotVO {
  int id;
  int parent_container_id;
  int privacy_level;

  String creator_uid;
  // assembled in AMF Endpoint via uid relation
  UGCUserVO creator;
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
  Map roles = new Map();
  // (assembled in AMF Endpoint via container_id relation in items table)
  Map items = new Map();
  // (assembled in AMF Endpoint via task_id relation in itemcontainer_tasks crosstable)
  UGCTaskVO task;
  UGCItemContainerVO([Map obj = null]) : super(obj) {

    if (obj.containsKey("creator")) {
      creator = new UGCUserVO(obj["creator"]);
      obj.remove("creator");
    }

    if (obj.containsKey("task")) {
      task = new UGCTaskVO(obj["task"]);
      obj.remove("task");
    }


    String prop;
    if (roles != null) {
      for (prop in roles) {
        roles[prop] = new UGCItemContainerRoleVO(roles[prop]);
      }
    }

    if (items != null) {
      for (prop in items) {
        items[prop] = new UGCItemVO(items[prop]);
      }
    }
  }
}
