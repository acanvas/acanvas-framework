part of acanvas_framework.screen;

/**
 * @author nilsdoehring
 */
class ScreenDisplaylistEffectApplyVO implements IAcVO {
  IEffect effect;
  LifecycleSprite target;
  num duration;

  ScreenDisplaylistEffectApplyVO(this.effect, this.target, this.duration) {}
}
