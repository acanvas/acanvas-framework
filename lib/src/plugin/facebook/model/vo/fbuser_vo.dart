part of stagexl_rockdot;

class FBUserVO extends RockdotVO {

  String id;
  String uid;
  String name;
  String first_name;
  String last_name;
  bool is_app_user;
  String pic_square;
  String locale;
  String email;
  String hometown_location;
  String birthday_date;
  FBUserVO([Object obj = null]) : super(obj) {
    if (id == "" && uid != "") {
      id = uid;
    }
    if (uid == "" && id != "") {
      uid = id;
    }
  }
}
