part of rockdot_dart;

@retain
class UGCUserVO extends RockdotVO {
  static const NETWORK_FACEBOOK = "facebook";
  static const NETWORK_GPLUS = "google+";
  static const NETWORK_INPUTFORM = "input form";

  String uid;
  String locale;
  String network;
  String device;
  String name;
  String pic;
  int login_count;
  String timestamp_registered;
  String timestamp_lastlogin;
  
  UGCUserVO([dynamic object = null]) : super(object);
}
