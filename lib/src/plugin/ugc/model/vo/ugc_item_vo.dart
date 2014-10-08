part of stagexl_rockdot;

@retain
class UGCItemVO extends RockdotVO {
    static const TYPE_TEXT = 0;
    static const TYPE_IMAGE = 1;
    static const TYPE_VIDEO = 2;
    static const TYPE_AUDIO = 3;
    static const TYPE_LINK = 4;
    int id;
    int container_id;
    String creator_uid;
    // assembled in AMF Endpoint via uid relation
    UGCUserVO creator;
    String title ;
    String description;
    int like_count  = 0;
    int complain_count = 0;
    int flag = 0;
    // 0: not blocked, 1: blocked
    String timestamp;
    int type;
    // 0:text, 1:image, 2:video, 3:audio, 4:link
    int type_id;
    // assembled in AMF Endpoint via type_id relation
    RockdotVO type_dao;
    // assembled in AMF Endpoint by counting array index
    int rowindex;
    // assembled in AMF Endpoint via supersmart extra query
    int totalrows;
    // optionally loaded via command
    List likers;

    UGCItemVO([dynamic obj = null]) : super(obj) {
      if (obj != null && obj["creator"] != null) {
        creator = new UGCUserVO(obj["creator"]);
        //delete obj.creator;
      }


      if (type_id != null) {
        switch(type) {
          case 0:
            type_dao = new UGCTextItemVO(obj);
            break;
          case 1:
            type_dao = new UGCImageItemVO(obj);
            break;
          case 2:
            type_dao = new UGCVideoItemVO(obj);
            break;
          case 3:
            type_dao = new UGCAudioItemVO(obj);
            break;
          case 4:
            // type_dao = obj;
            break;
        }
      }
      var prop;
      if (likers != null) {
        for (prop  in  likers) {
          likers[prop] = new UGCUserVO(likers[prop]);
        }
      }
    }
  }