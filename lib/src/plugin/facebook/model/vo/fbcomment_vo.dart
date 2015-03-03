part of stagexl_rockdot.facebook;

class FBCommentVO {

  String id;
  String created_time;
  String from_name;
  String from_id;
  int like_count;
  bool user_likes;
  String message;

  FBCommentVO([dynamic vo = null]) {
    if (vo != null) {
      id = vo["uid"];
      created_time = vo["created_time"];
      from_name = vo["from"]["name"];
      from_id = vo["from"]["id"];
      like_count = vo["like_count"];
      user_likes = vo["user_likes"];
      message = vo["message"];
    }
  }
}
