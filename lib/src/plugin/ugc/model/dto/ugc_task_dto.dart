part of stagexl_rockdot.ugc;

/**
	 * @author nilsdoehring
	 */
class UGCTaskDTO extends UGCItemContainerDTO {

  int category_id;
  String task_key;

  //type: 0:text, 1:image, 2:video, 3:audio, 4:link
  int type;

  //extras (assembled in AMF Endpoint via category_id relation)
  String category_key;

  UGCTaskDTO([Map inputDTO = null]) {
    if (inputDTO != null) {
      category_id = inputDTO["category_id"];
      task_key = inputDTO["task_key"];
      type = inputDTO["type"];
      category_key = inputDTO["category_key"];
    }
  }

  @override
  Map toJson() {
    return {
      "category_id": category_id,
      "task_key": task_key,
      "type": type,
      "category_key": category_key
    };
  }
}
