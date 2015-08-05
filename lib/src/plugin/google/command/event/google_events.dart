part of stagexl_rockdot.google;

/**
 * @author nilsdoehring
 */
class GoogleEvents {

  static const String INIT = "GoogleEvents.INIT";

  //expects perms (optional), sets _gModel.client
  static const String USER_LOGIN = "GoogleEvents.USER_LOGIN";

  /* The following Events require a valid _gModel.client*/
  static const String PLUS_USER_GET = "GoogleEvents.PLUS_USER_GET";
  static const String PLUS_MOMENTS_GET = "GoogleEvents.MOMENTS_GET";
  static const String PLUS_PEOPLE_GET = "GoogleEvents.PEOPLE_GET";

  static const String PLUS_SHARE_RENDER = "GoogleEvents.PLUS_SHARE_RENDER";
}
