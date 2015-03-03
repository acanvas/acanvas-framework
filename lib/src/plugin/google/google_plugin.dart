part of stagexl_rockdot.google;

class GooglePlugin extends AbstractPlugin {
  static const String MODEL_GOOGLE = "MODEL_GOOGLE";
  GooglePlugin() : super(30) {
  }
  
  /**
   * Registers Commands with FrontController 
   * You can then access them from anywhere:
   * new XLSignal(GoogleEvents.SOME_COMMAND, optionalParam, optionalCompleteCallback).dispatch();
   */
  @override void configureCommands() {
    commandMap[GoogleEvents.INIT] = GoogleInitCommand;
    commandMap[GoogleEvents.USER_LOGIN] = GoogleLoginCommand;
    commandMap[GoogleEvents.PLUS_USER_GET] = GooglePlusGetUserCommand;
    
    commandMap[GoogleEvents.PLUS_MOMENTS_GET] = GooglePlusMomentsGetCommand;
    commandMap[GoogleEvents.PLUS_PEOPLE_GET] = GooglePlusPeopleGetCommand;
    
    commandMap[GoogleEvents.PLUS_SHARE_RENDER] = GooglePlusShareRenderCommand;
    
    projectInitCommand = GoogleEvents.INIT;
  }

  /**
     * Register this Plugin's Model as injectable
     * Any class requiring this Model can implement IGoogleModelAware and the ObjectFactory will take care.
     * This is called Interface Injection, the only kind of injection available in Spring Dart so far.
     * Feel free to add more injectors. 
     */
  @override void configureInjectors() {
    RockdotContextHelper.registerInstance(objectFactory, MODEL_GOOGLE, new GoogleModel());
    objectFactory.addObjectPostProcessor(new GoogleModelInjector(objectFactory));
  }

}
