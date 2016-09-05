part of rockdot_framework.babylon;

class BabylonPlugin extends AbstractRdPlugin {
  bool _autoInit;


  BabylonPlugin({bool autoInit: false}) : super(40) {
    _autoInit = autoInit;
  }

  /**
   * Registers Commands with FrontController
   * You can then access them from anywhere:
   * new RdSignal(FacebookEvents.SOME_COMMAND, optionalParam, optionalCompleteCallback).dispatch();
   */
  @override void configureCommands() {

    commandMap[BabylonEvents.INIT] = () => new BabylonInitBrowserCommand();

    if(_autoInit){
      projectInitCommand = BabylonEvents.INIT;
    }
  }

}
