part of acanvas_framework.screen;

/**
 * @author nilsdoehring
 */
class ScreenDisplaylistTransitionPrepareVO implements IAcVO {
  LifecycleSprite outTarget;
  LifecycleSprite inTarget;
  IEffect effect;
  bool modal;
  String transitionType;
  num initialAlpha = 0;

  ScreenDisplaylistTransitionPrepareVO(
      this.transitionType, this.outTarget, this.effect, this.inTarget,
      {this.modal: false, this.initialAlpha: 0}) {}
}
