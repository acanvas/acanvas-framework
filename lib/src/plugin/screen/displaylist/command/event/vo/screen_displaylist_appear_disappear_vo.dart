part of stagexl_rockdot.screen;

/**
 * @author nilsdoehring
 */
class ScreenDisplaylistAppearDisappearVO implements IXLVO {
  LifecycleSprite target;
  num duration;
  bool autoDispose;

  ScreenDisplaylistAppearDisappearVO(this.target, this.duration, [this.autoDispose = false]) {
  }
}
