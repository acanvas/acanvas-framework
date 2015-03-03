part of stagexl_rockdot.screen;

@retain
class ScreenDisappearCommand extends AbstractScreenCommand {
  ScreenDisplaylistAppearDisappearVO _vo;

  @override void execute([XLSignal event = null]) {
    super.execute(event);

    _vo = event.data;
    _vo.target.addEventListener(ManagedSpriteComponentEvent.DISAPPEAR_COMPLETE, dispatchCompleteEvent);
    _vo.target.disappear(_vo.duration);
  }

  @override bool dispatchCompleteEvent([dynamic result = null]) {
    _vo.target.removeEventListener(ManagedSpriteComponentEvent.DISAPPEAR_COMPLETE, dispatchCompleteEvent);
    // _vo.target.alpha = 0;
    // _vo.target.visible = false;

    if (_vo.autoDestroy == true) {
      _vo.target.destroy();
    }

    return super.dispatchCompleteEvent(result);
  }
}
