part of rockdot_framework.io;

class IOPlugin extends AbstractRdPlugin {
  IOPlugin() : super(35) {
  }

  /**
   * Registers Commands with FrontController
   * You can then access them from anywhere:
   * new RdSignal(IOEvents.SOME_COMMAND, optionalParam, optionalCompleteCallback).dispatch();
   */
  @override void configureCommands() {
    commandMap[IOEvents.UPLOAD_IMAGE] = () => new IOImageUploadCommand();
  }

  /**
   * Register this Plugin's Model as injectable
   * Any class requiring this Model can implement IIOModelAware and the ObjectFactory will take care.
   * This is called Interface Injection, the only kind of injection available in Spring Dart so far.
   * Feel free to add more injectors.
   */
  @override void configureInjectors() {
    /* This Plugin doesn't need a Model */
  }

}
