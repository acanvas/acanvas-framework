part of stagexl_rockdot.screen;

class ScreenPluginBase extends AbstractPlugin {
  static const String MODEL_UI = "MODEL_UI";
  static const String SERVICE_UI = "SERVICE_UI";
  
  ScreenPluginBase() : super(20) {
  }
  
  /**
   * Registers Commands with FrontController 
   * You can then access them from anywhere:
   * new XLSignal(StateEvents.SOME_COMMAND, optionalParam, optionalCompleteCallback).dispatch();
   */
  @override void configureCommands() {
    commandMap[ScreenEvents.INIT] = () => new ScreenPluginInitCommand();
    commandMap[ScreenEvents.RESIZE] = () => new ScreenResizeCommand();
    // ## COMMAND INSERTION PLACEHOLDER - DO NOT REMOVE ## //


    /* Add this Plugin's Init Command to Bootstrap Command Sequence */
    projectInitCommand = ScreenEvents.INIT;
  }

  /**
     * Register this Plugin's Model as injectable
     * Any class requiring this Model can implement IScreenModelAware and the ObjectFactory will take care.
     * This is called Interface Injection, the only kind of injection available in Spring Dart so far.
     * Feel free to add more injectors. 
     */
  @override void configureInjectors() {
    RockdotContextHelper.registerInstance(objectFactory, MODEL_UI, new ScreenModel());
    objectFactory.addObjectPostProcessor(new ScreenPluginInjector(objectFactory));
  }

}
