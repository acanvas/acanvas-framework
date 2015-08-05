part of stagexl_rockdot.core;


class RockdotConstants {

  /* internals */
  LoaderInfo _loaderInfo;
  List<String> _bootStrap;
  IApplicationContext _context;
  bool _debug;

  static const String VAR_ITEM_CONTAINER_ID = "item_container_id";
  static const String VAR_ITEM_ID = "item_id";
  static const String VAR_REASON_KEY = "reason";
  static const String VAR_REASON_VALUE_APPREQUEST_VIEW = "apprequest_view";
  static const String VAR_REASON_VALUE_APPREQUEST_PARTICIPATE = "apprequest_participate";
  static const String VAR_REASON_VALUE_SHARE = "share";

  /* defaults if no vars are given */
  static const String COUNTRY_DEFAULT = Countries.USA;
  static const String MARKET_DEFAULT = Markets.USA;
  static const String LANGUAGE_DEFAULT = Languages.ENGLISH;


  static const int UPLOAD_WIDTH_MAX = 720;
  static const int UPLOAD_HEIGHT_MAX = 720;
  static const int UPLOAD_WIDTH_THUMB = 120;
  static const int UPLOAD_HEIGHT_THUMB = 120;


  static int get WIDTH_STAGE_REAL {
    return RockdotConstants.getStage().stageWidth;
  }

  static int get HEIGHT_STAGE_REAL {
    return RockdotConstants.getStage().stageHeight;
  }


  factory RockdotConstants() {
    return _singleton;
  }

  static final RockdotConstants _singleton = new RockdotConstants._internal();

  RockdotConstants._internal() {
    // initialization logic here
    _bootStrap = new List<String>();
  }

  /*
		 * Setting Loaderinfo 
		 */

  static void setLoaderInfo(LoaderInfo loaderInfo) {
    _singleton._loaderInfo = (loaderInfo);
  }

  static List<String> getBootstrap() {
    return _singleton._bootStrap;
  }

  static Stage getStage() {
    return ContextTool.STAGE;
  }

  static void setStage(Stage stage) {
    ContextTool.STAGE = (stage);
  }

  static bool get WEBGL {
    return ContextTool.WEBGL;
  }

  static void set WEBGL(bool gl) {
    ContextTool.WEBGL = gl;
  }

  static IApplicationContext getContext() {
    return _singleton._context;
  }

  static void setContext(IApplicationContext ctx) {
    _singleton._context = (ctx);
  }

  /**
   *  The PHP session ID
   *  "" if LOCAL is true
   */
  static String get PHP_SESSION_ID {
    if (_singleton._loaderInfo.php_session_id != "") {
      return _singleton._loaderInfo.php_session_id;
    }
    return "";
  }

  /**
   *  The Protocol as detected by php
   *  "" if LOCAL is true
   */
  static String get PROTOCOL {
    if (_singleton._loaderInfo.protocol != "") {
      return _singleton._loaderInfo.protocol;
    }
    return "";
  }


  /**
   *  The Frontend Host as configured in @see project.properties
   *  "" if LOCAL is true
   */
  static String get HOST_FRONTEND {
    if (_singleton._loaderInfo.host_frontend != "") {
      return _singleton._loaderInfo.host_frontend;
    }
    return "";
  }

  /**
   *  The Language of the user's locale
   *  OR the one set by $_GET["language"]
   *  OR the default language as configured in @see project.properties
   */
  static String get LANGUAGE {
    if (_singleton._loaderInfo.language != "") {
      return _singleton._loaderInfo.language;
    }
//			if(!str) str = Capabilities.language.substr(0, 2);

    return LANGUAGE_DEFAULT;
  }

  /**
   * The Market set in PHP (mostly via $_GET["market"])
   *  OR the default market as configured in @see project.properties
   */
  static String get MARKET {
    if (_singleton._loaderInfo.market != "") {
      return _singleton._loaderInfo.market;
    }

    return MARKET_DEFAULT;
  }

  /**
   *  The Country of the user's locale
   *  OR the default country as configured in @see project.properties
   */
  static String get COUNTRY {
    if (_singleton._loaderInfo.market != "") {
      return _singleton._loaderInfo.country;
    }

    return COUNTRY_DEFAULT;
  }

  /**
   *  The directory to load the config from. The standard is "v1", as configured in @see project.properties
   */
  static String get VERSION {
    if (_singleton._loaderInfo.version != "") {
      return _singleton._loaderInfo.version;
    }
    return "v1";
  }

  /**
   *  Direct access to APP_DATA FlashParam
   */
  static String get APP_DATA {
    //retrieve URLVariable ("app_data")
    return _singleton._loaderInfo.app_data;
  }

  /**
   *  Reads keys from base64 encoded string in APP_DATA FlashVar
   *  mostly set if there's an initial deeplink (which can't be set as Anchor via Facebook's Frame)
   */
  static String URLVAR(String key) {
    //retrieve URLVariable ("app_data")
    if (_singleton._loaderInfo.app_data == "") {
      return null;
    }

    //TODO decode app_data
    //_singleton._loaderInfo.app_data = Base64Codec.codec.decodeString(_singleton._loaderInfo.app_data);
    //str_app_data = Base64.decode(str_app_data);

    //split query string
    List a_temp = _singleton._loaderInfo.app_data.split("&");
    Map<String, String> app_data = new Map();
    for (int i = 0; i < a_temp.length; i++) {
      app_data[a_temp[i].split("=")[0]] = a_temp[i].split("=")[1];
    }

    //return value for key
    return app_data[key];
  }


  /**
   *  Debug mode switch. Enables/Disables Logger.
   *  @see config/users/username.properties
   */
  static bool get DEBUG {
    return _singleton._debug;
  }

  static void set DEBUG(bool dbg) {
    _singleton._debug = dbg;
  }

  /**
   * Local mode switch. Enables/Disables Facebook Functionality and Fake User
   */
  static bool get LOCAL {
    return _singleton._loaderInfo.local == "true" ? true : false;
  }
}
