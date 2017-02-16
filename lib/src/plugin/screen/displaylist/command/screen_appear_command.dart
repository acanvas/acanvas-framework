part of rockdot_framework.screen;

//@retain
class ScreenAppearCommand extends AbstractScreenCommand {
  ScreenDisplaylistAppearDisappearVO _vo;

  @override
  void execute([RdSignal event = null]) {
    super.execute(event);

    _vo = event.data;
    _vo.target.addEventListener(LifecycleEvent.APPEAR_COMPLETE, dispatchCompleteEvent);
    _vo.target.appear(duration: _vo.duration);
  }

  @override
  bool dispatchCompleteEvent([dynamic result = null]) {
    _vo.target.removeEventListener(LifecycleEvent.APPEAR_COMPLETE, dispatchCompleteEvent);
    // _vo.target.alpha = 1;
    // _vo.target.visible = true;

    if (_vo.autoDispose == true) {
      _vo.target.dispose();
    }

    return super.dispatchCompleteEvent(result);
  }
}
