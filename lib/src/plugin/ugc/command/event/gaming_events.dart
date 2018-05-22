part of rockdot_framework.ugc;

/**
 * @author nilsdoehring
 */
class GamingEvents {
  //expects GameDAO, returns Object {score:int, rank:int} (for all levels combined)
  static const String SET_SCORE_AT_LEVEL = "GamingEvents.SET_SCORE_AT_LEVEL";

  //expects nothing, returns Object {topFiveFriends:List, topTen:List, rank:int}
  static const String GET_HIGHSCORE = "GamingEvents.GET_HIGHSCORE";

  //expects nothing, returns OperationEvent with result = {games:array of GameDAOs}
  static const String GET_GAMES = "GamingEvents.GET_GAMES";

  //expects score, returns OperationEvent with same result as GET_GAMES
  static const String SAVE_GAME = "GamingEvents.SAVE_GAME";

  //expects uid, returns bool
  static const String CHECK_PERMISSION_TO_PLAY =
      "GamingEvents.CHECK_PERMISSION_TO_PLAY";

  //expects {uid, locale}, returns bool
  static const String CHECK_PERMISSION_TO_PLAY_LOCALE =
      "GamingEvents.CHECK_PERMISSION_TO_PLAY_LOCALE";
}
