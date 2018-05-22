part of rockdot_framework.facebook;

class FBConstants {
  /* internals */

  static const String VAR_ITEM_CONTAINER_ID = "item_container_id";
  static const String VAR_ITEM_ID = "item_id";
  static const String VAR_REASON_KEY = "reason";
  static const String VAR_REASON_VALUE_APPREQUEST_VIEW = "apprequest_view";
  static const String VAR_REASON_VALUE_APPREQUEST_PARTICIPATE =
      "apprequest_participate";
  static const String VAR_REASON_VALUE_SHARE = "share";

  /**
   *  Reads keys from base64 encoded string in APP_DATA FlashVar
   *  mostly set if there's an initial deeplink (which can't be set as Anchor via Facebook's Frame)
   */
  static String URLVAR(String key) {
    //TODO decode app_data
    /*
      //retrieve URLVariable ("app_data")
      if (_singleton._loaderInfo.app_data == "") {
        return null;
      }
      _singleton._loaderInfo.app_data = Base64Codec.codec.decodeString(_singleton._loaderInfo.app_data);
      str_app_data = Base64.decode(str_app_data);


    //split query string
    List a_temp = _singleton._loaderInfo.app_data.split("&");
    Map<String, String> app_data = new Map();
    for (int i = 0; i < a_temp.length; i++) {
      app_data[a_temp[i].split("=")[0]] = a_temp[i].split("=")[1];
    }

    //return value for key
    return app_data[key];
     */
    return key;
  }
}
