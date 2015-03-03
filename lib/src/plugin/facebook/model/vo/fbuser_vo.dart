part of stagexl_rockdot.facebook;

class FBUserVO {

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

  FBUserVO([dynamic vo = null]) {
    if (vo != null) {
      birthday_date = vo["birthday_date"];
      id = vo["uid"];
      uid = vo["uid"];
      name = vo["name"];
      pic_square = vo["pic_square"];
      email = vo["email"];
      hometown_location = vo["hometown_location"] is js.JsObject ? vo["hometown_location"]["name"] : vo["hometown_location"];
      locale = vo["locale"];
      is_app_user = vo["is_app_user"];
    }
  }
}
