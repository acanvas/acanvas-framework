part of rockdot_dart;

class DeviceDetector {
  static String get VERSION {
    return "Dart";
    //return Capabilities.version;
  }

  static bool get IS_AIR {
    return IS_MOBILE || IS_DESKTOP;
  }

  static bool get IS_MOBILE {
    return IS_IOS || IS_ANDROID;
  }

  static bool get IS_DESKTOP {
    return true;
    //return Capabilities.playerType == "Desktop";
  }

  static bool get IS_IOS {
    return false;
    //return (Capabilities.version).substr(0, 3) == "IOS";
  }

  static bool get IS_ANDROID {
    return false;
    //return  (Capabilities.version).substr(0, 3) == "AND";
  }
}
