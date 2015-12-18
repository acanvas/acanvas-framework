part of stagexl_rockdot.screen;

/**
 * @author nilsdoehring
 */
class ScreenDisplaylistTransitionApplyVO implements IRdVO {
  IEffect effect;
  String transitionType;
  LifecycleSprite targetPrimary;
  LifecycleSprite targetSecondary;
  num duration;

  ScreenDisplaylistTransitionApplyVO(this.effect, this.transitionType, this.targetPrimary, this.duration, [this.targetSecondary = null]) {
  }
}
