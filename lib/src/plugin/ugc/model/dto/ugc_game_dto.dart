part of rockdot_framework.ugc;

/**
 * @author nilsdoehring
 */
class UGCGameDTO implements IRdDTO {
  String uid;
  int level;
  num score;
  String control;
  String timestamp;

  UGCGameDTO([Map inputDTO = null]) {
    if (inputDTO != null) {
      uid = inputDTO["uid"];
      level = inputDTO["level"];
      score = inputDTO["score"];
      control = inputDTO["control"];
      timestamp = inputDTO["timestamp"];
    }
  }

  @override
  Map toJson() {
    return {
      "uid": uid,
      "level": level,
      "score": score,
      "control": control,
      "timestamp": timestamp
    };
  }
}
