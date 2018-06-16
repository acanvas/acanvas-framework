part of acanvas_framework.screen;

class ScreenLoadCommand extends AbstractScreenCommand {
  @override
  void execute([AcSignal event = null]) {
    super.execute(event);

    LifecycleSprite ui;
    if (event.data != null) {
      ui = (event.data as LifecycleSprite);
    } else if (_stateModel.currentScreen != null) {
      ui = _stateModel.currentScreen;
    }

    if (ui.requiresLoading == true) {
      new AcSignal(
              StateEvents.MESSAGE_SHOW,
              new StateMessageVO(
                  "lifecycle.load", getProperty("screen.common.loading"), 0,
                  type: StateMessageVO.TYPE_LOADING, blurContent: false))
          .dispatch();
      ui.load(params: _stateModel.currentStateURLParams).then((_) {
        new AcSignal(StateEvents.MESSAGE_HIDE, "lifecycle.load").dispatch();
        dispatchCompleteEvent();
      }, onError: dispatchErrorEvent);
    } else {
      dispatchCompleteEvent();
    }
  }
}
