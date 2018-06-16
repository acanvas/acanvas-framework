part of acanvas_framework.screen;

/**
 * @author nilsdoehring
 */
class ScreenDisplaylistTransitionApplyVO implements IAcVO {
  IEffect effect;
  String transitionType;
  LifecycleSprite targetPrimary;
  LifecycleSprite targetSecondary;
  num duration;

  ScreenDisplaylistTransitionApplyVO(
      this.effect, this.transitionType, this.targetPrimary, this.duration,
      [this.targetSecondary = null]) {}
}
