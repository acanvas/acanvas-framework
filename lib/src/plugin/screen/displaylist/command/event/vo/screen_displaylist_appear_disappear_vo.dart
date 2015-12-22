part of rockdot_framework.screen;

/**
 * @author nilsdoehring
 */
class ScreenDisplaylistAppearDisappearVO implements IRdVO {
  LifecycleSprite target;
  num duration;
  bool autoDispose;

  ScreenDisplaylistAppearDisappearVO(this.target, this.duration, [this.autoDispose = false]) {
  }
}
