part of stagexl_rockdot.screen;

class ScreenResizeCommand extends AbstractScreenCommand {

  @override dynamic execute([RdSignal event=null]) {
    super.execute(event);

    if (event.data != null) {
      if (event.data is MBox) {
        (event.data as MBox).span(_uiService.stage.stageWidth, _uiService.stage.stageHeight);
      }
      else {
        this.log.finer("Nothing to resize.");
      }
    }
    else {
      ///only execute if not already resized via [AbstractScreenService]
      if (_stateModel.currentScreen != null && _stateModel.currentScreen.inheritSpan) {
        _stateModel.currentScreen.span(_uiService.stage.stageWidth, _uiService.stage.stageHeight);
      }
    }

    dispatchCompleteEvent();

    return null;
  }
}

