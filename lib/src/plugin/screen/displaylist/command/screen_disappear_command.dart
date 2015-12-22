part of rockdot_framework.screen;

//@retain
class ScreenDisappearCommand extends AbstractScreenCommand {
  ScreenDisplaylistAppearDisappearVO _vo;

  @override void execute([RdSignal event = null]) {
    super.execute(event);

    _vo = event.data;
    _vo.target.addEventListener(LifecycleEvent.DISAPPEAR_COMPLETE, dispatchCompleteEvent);
    _vo.target.disappear(duration: _vo.duration);
  }

  @override bool dispatchCompleteEvent([dynamic result = null]) {
    _vo.target.removeEventListener(LifecycleEvent.DISAPPEAR_COMPLETE, dispatchCompleteEvent);

    if (_vo.autoDispose == true) {
      _vo.target.dispose();
    }

    return super.dispatchCompleteEvent(result);
  }
}
