part of stagexl_rockdot.ugc;

/**
 * @author nilsdoehring
 */
class UGCFilterVO extends DataRetrieveVO {

  static const String CONDITION_ALL = "CONDITION_ALL";
  static const String CONDITION_ME = "CONDITION_ME";
  static const String CONDITION_FRIENDS = "CONDITION_FRIENDS";
  static const String CONDITION_UID = "CONDITION_UID";
  static const String CONDITION_UGC_ID = "CONDITION_UGC_ID";

  static const String ORDER_DATE_DESC = "timestamp DESC";
  static const String ORDER_LIKES_DESC = "like_count DESC";

  String condition;
  String order;

  //ONE (and only one) of these needs to be set
  List creator_uids; //CONDITION_FRIENDS
  String creator_uid; //CONDITION_ME, CONDITION_UID
  int item_id; //CONDITION_UGC_ID

  UGCFilterVO(this.condition, this.order, int limit) : super(limit) {
  }
  
  Map toMap(){
    Map map = {
      "condition": condition,         
      "order": order,         
      "limit": limit,         
      "nextToken": nextToken         
    };
    
    switch(condition){
      case CONDITION_FRIENDS:
        map["creator_uids"] = creator_uids;
        break;
      case CONDITION_ME:
      case CONDITION_UID:
        map["creator_uid"] = creator_uid;
        break;
      case CONDITION_UGC_ID:
        map["item_id"] = item_id;
        break;
    }
    
    return map;
  }
  
}
