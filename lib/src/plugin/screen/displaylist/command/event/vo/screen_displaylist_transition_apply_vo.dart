part of stagexl_rockdot;

/**
 * @author nilsdoehring
 */
class ScreenDisplaylistTransitionApplyVO implements IXLVO {
  IEffect effect;
  String transitionType;
  ISpriteComponent targetPrimary;
  ISpriteComponent targetSecondary;
  num duration;

  ScreenDisplaylistTransitionApplyVO(this.effect, this.transitionType, this.targetPrimary, this.duration, [this.targetSecondary = null]) {
  }
}
