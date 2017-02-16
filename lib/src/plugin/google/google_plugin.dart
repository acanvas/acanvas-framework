part of rockdot_framework.google;

class GooglePlugin extends AbstractRdPlugin {
  static const String MODEL_GOOGLE = "MODEL_GOOGLE";

  GooglePlugin() : super(30) {}

  /**
   * Registers Commands with FrontController
   * You can then access them from anywhere:
   * new RdSignal(GoogleEvents.SOME_COMMAND, optionalParam, optionalCompleteCallback).dispatch();
   */
  @override
  void configureCommands() {
    commandMap[GoogleEvents.INIT] = () => new GoogleInitCommand();
    commandMap[GoogleEvents.USER_LOGIN] = () => new GoogleLoginCommand();
    commandMap[GoogleEvents.PLUS_USER_GET] = () => new GooglePlusGetUserCommand();

    commandMap[GoogleEvents.PLUS_PEOPLE_GET] = () => new GooglePlusPeopleGetCommand();

    commandMap[GoogleEvents.PLUS_SHARE_RENDER] = () => new GooglePlusShareRenderCommand();

    commandMap[GoogleEvents.SPEECH_RECOGNIZE] = () => new GoogleSpeechRestCommand();

    projectInitCommand = GoogleEvents.INIT;
  }

  /**
   * Register this Plugin's Model as injectable
   * Any class requiring this Model can implement IGoogleModelAware and the ObjectFactory will take care.
   * This is called Interface Injection, the only kind of injection available in Spring Dart so far.
   * Feel free to add more injectors.
   */
  @override
  void configureInjectors() {
    RdContextUtil.registerInstance(objectFactory, MODEL_GOOGLE, new GoogleModel());
    objectFactory.addObjectPostProcessor(new GoogleModelInjector(objectFactory));
  }
}
