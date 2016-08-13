part of rockdot_framework.screen;

//@retain
class ScreenLoadCommand extends AbstractScreenCommand {

  @override void execute([RdSignal event = null]) {
    super.execute(event);

    LifecycleSprite ui;
    if (event.data != null) {
      ui = (event.data as LifecycleSprite);
    } else if (_stateModel.currentScreen != null) {
      ui = _stateModel.currentScreen;
    }

    if (ui.requiresLoading == true) {
      ui.addEventListener(LifecycleEvent.LOAD_COMPLETE, dispatchCompleteEvent);
      ui.addEventListener(LifecycleEvent.LOAD_ERROR, dispatchErrorEvent);
      ui.load(params: _stateModel.currentStateURLParams);
    } else {
      dispatchCompleteEvent();
    }
  }
}
