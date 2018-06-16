part of acanvas_framework.screen;

/**
 * @author nilsdoehring
 */
class ScreenDisplaylistAppearDisappearVO implements IAcVO {
  LifecycleSprite target;
  double duration;
  bool autoDispose;

  ScreenDisplaylistAppearDisappearVO(this.target, this.duration,
      [this.autoDispose = false]) {}
}
