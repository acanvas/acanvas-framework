part of rockdot_framework.screen;

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
