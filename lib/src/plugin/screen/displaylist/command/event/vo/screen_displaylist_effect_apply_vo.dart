part of stagexl_rockdot.screen;

/**
 * @author nilsdoehring
 */
class ScreenDisplaylistEffectApplyVO implements IRdVO {
  IEffect effect;
  LifecycleSprite target;
  num duration;

  ScreenDisplaylistEffectApplyVO(this.effect, this.target, this.duration) {
  }
}
