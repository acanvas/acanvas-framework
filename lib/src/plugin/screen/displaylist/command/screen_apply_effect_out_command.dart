part of rockdot_framework.screen;

class ScreenApplyEffectOutCommand extends AbstractScreenCommand {
  @override
  void execute([RdSignal event = null]) {
    super.execute(event);

    ScreenDisplaylistEffectApplyVO vo = event.data;
    vo.effect.runOutEffect(vo.target, vo.duration, dispatchCompleteEvent);
  }

  @override
  bool dispatchCompleteEvent([dynamic result = null]) {
    return super.dispatchCompleteEvent(result);
  }
}
