part of rockdot_framework.ugc;

/**
 * @author nilsdoehring
 */
class UGCItemContainerRoleDTO implements IRdDTO {
  int id;
  int container_id;
  String uid;
  int role;

  //0:owner, 1:participant, 2:follower
  String timestamp;

  UGCItemContainerRoleDTO([Map inputDTO = null]) {
    if (inputDTO != null) {
      id = inputDTO["id"];
      container_id = inputDTO["container_id"];
      uid = inputDTO["uid"];
      role = inputDTO["role"];
      timestamp = inputDTO["timestamp"];
    }
  }

  @override
  Map toJson() {
    return {"id": id, "container_id": container_id, "uid": uid, "role": role, "timestamp": timestamp};
  }
}
