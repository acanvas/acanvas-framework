part of stagexl_rockdot;

class GooglePlugin extends AbstractOrderedFactoryPostProcessor {
  static const String MODEL_GOOGLE = "MODEL_GOOGLE";
  GooglePlugin() : super(30) {
  }

  @override
  IOperation postProcessObjectFactory(IObjectFactory objectFactory) {

    /* Objects */
    RockdotContextHelper.registerInstance(objectFactory, MODEL_GOOGLE, new GoogleModel());

    /* Object Postprocessors */
    objectFactory.addObjectPostProcessor(new GoogleModelInjector(objectFactory));

    /* Commands */
    Map commandMap = new Map();


    commandMap[GoogleEvents.INIT] = GoogleInitCommand;
    commandMap[GoogleEvents.USER_LOGIN] = GoogleLoginCommand;
    commandMap[GoogleEvents.PLUS_USER_GET] = GooglePlusGetUserCommand;
    
    commandMap[GoogleEvents.PLUS_MOMENTS_GET] = GooglePlusMomentsGetCommand;
    commandMap[GoogleEvents.PLUS_PEOPLE_GET] = GooglePlusPeopleGetCommand;
    
    commandMap[GoogleEvents.PLUS_SHARE_RENDER] = GooglePlusShareRenderCommand;

    RockdotContextHelper.registerCommands(objectFactory, commandMap);


    /* Bootstrap Command */
   // RockdotConstants.getBootstrap().add(GoogleEvents.INIT);

    return null;
  }

}
