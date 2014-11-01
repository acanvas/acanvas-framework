part of stagexl_rockdot;

class IOPlugin extends AbstractOrderedFactoryPostProcessor {
  IOPlugin() : super(35) {
  }

  @override
  IOperation postProcessObjectFactory(IObjectFactory objectFactory) {

    /* Commands */
    Map commandMap = new Map();
    commandMap[IOEvents.UPLOAD_IMAGE] = FBPromptShareCommand;
    RockdotContextHelper.registerCommands(objectFactory, commandMap);

    return null;
  }

}
