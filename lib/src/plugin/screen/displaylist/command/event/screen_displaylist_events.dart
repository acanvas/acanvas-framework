part of acanvas_framework.screen;

/**
 * @author Nils Doehring (nilsdoehring(gmail as at).com)
 */
class ScreenDisplaylistEvents {
  static const String SCREEN_LOAD = "ScreenDisplaylistEvents.SCREEN_LOAD";
  static const String SCREEN_INIT = "ScreenDisplaylistEvents.SCREEN_INIT";

  //expects VOUITransition
  static const String TRANSITION_PREPARE =
      "ScreenDisplaylistEvents.TRANSITION_PREPARE";

  //expects VOUIApplyEffect
  static const String TRANSITION_RUN = "ScreenDisplaylistEvents.TRANSITION_RUN";
  static const String APPLY_EFFECT_IN =
      "ScreenDisplaylistEvents.APPLY_EFFECT_IN";
  static const String APPLY_EFFECT_OUT =
      "ScreenDisplaylistEvents.APPLY_EFFECT_OUT";

  //expects VOUIAppearDisappear
  static const String APPEAR = "ScreenDisplaylistEvents.APPEAR";
  static const String DISAPPEAR = "ScreenDisplaylistEvents.DISAPPEAR";
}
