part of stagexl_rockdot.screen;

/**
 * @author nilsdoehring
 */
class ScreenDisplaylistEffectApplyVO implements IXLVO {
  IEffect effect;
  ISpriteComponent target;
  num duration;

  ScreenDisplaylistEffectApplyVO(this.effect, this.target, this.duration) {
  }
}
