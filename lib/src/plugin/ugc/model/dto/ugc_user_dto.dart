part of rockdot_framework.ugc;

class UGCUserDTO implements IRdDTO {
  static const NETWORK_FACEBOOK = "facebook";
  static const NETWORK_GPLUS = "google+";
  static const NETWORK_INPUTFORM = "inputform";

  String uid;
  String locale;
  String network;
  String device;
  String name;
  String pic;
  int login_count = 0;
  String timestamp_registered;
  String timestamp_lastlogin;

  UGCUserDTO([Map inputDTO = null]) {
    if (inputDTO != null) {
      uid = inputDTO["uid"].toString();
      locale = inputDTO["locale"];
      network = inputDTO["network"];
      device = inputDTO["device"];
      name = inputDTO["name"];
      pic = inputDTO["pic"];
      login_count = inputDTO["login_count"];
      timestamp_registered = inputDTO["timestamp_registered"];
      timestamp_lastlogin = inputDTO["timestamp_lastlogin"];
    }
  }

  @override
  Map toJson() {
    return {
      "uid": uid,
      "locale": locale,
      "network": network,
      "device": device,
      "name": name,
      "pic": pic,
      "login_count": login_count,
      "timestamp_registered": timestamp_registered,
      "timestamp_lastlogin": timestamp_lastlogin
    };
  }
}
