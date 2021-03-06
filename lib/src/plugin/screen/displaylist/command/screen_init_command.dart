part of acanvas_framework.screen;

class ScreenInitCommand extends AbstractScreenCommand {
  @override
  void execute([AcSignal event = null]) {
    super.execute(event);

    LifecycleSprite ui;
    if (event.data != null) {
      ui = (event.data as LifecycleSprite);
    } else if (_stateModel.currentScreen != null) {
      ui = _stateModel.currentScreen;
    }

    if (ui.initialized == true) {
      dispatchCompleteEvent();
    } else {
      ui.addEventListener(LifecycleEvent.INIT_COMPLETE, dispatchCompleteEvent);
      ui.init(params: _stateModel.currentStateURLParams);
    }
  }
}
