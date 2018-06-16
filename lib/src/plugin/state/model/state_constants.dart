part of acanvas_framework.state;

class StateConstants {
  /* APPLICATION STATES */
  static const String MAIN_LOADING = "StateConstants.MAIN_LOADING";
  static const String MAIN_INITIALIZING = "StateConstants.MAIN_INITIALIZING";
  static const String MAIN_TRANSITIONING = "StateConstants.MAIN_TRANSITIONING";
  static const String MAIN_PRESENTING = "StateConstants.MAIN_PRESENTING";
  static const String MAIN_PRESENTING_3D = "StateConstants.MAIN_PRESENTING_3D";
  static const String MAIN_IDLING = "StateConstants.MAIN_IDLING";

  /* APPLICATION SUBSTATES */
  static const String SUB_NORMAL = "StateConstants.SUB_NORMAL";
  static const String SUB_MODAL = "StateConstants.SUB_MODAL";
  static const String SUB_LOCKED = "StateConstants.SUB_LOCKED";
  static const String SUB_ERROR = "StateConstants.SUB_ERROR";

  /* Context IDs: Models */
  static const String CTX_MODEL_STATE = "CTX_MODEL_STATE";
}
