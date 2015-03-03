part of stagexl_rockdot.screen;

/**
 * @author nilsdoehring
 */
class ScreenDisplaylistAppearDisappearVO implements IXLVO {
  ISpriteComponent target;
  num duration;
  bool autoDestroy;
  
  ScreenDisplaylistAppearDisappearVO(this.target, this.duration, [this.autoDestroy = false]) {
  }
}
