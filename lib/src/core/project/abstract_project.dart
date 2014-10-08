part of stagexl_rockdot;

class AbstractProject extends AbstractOrderedFactoryPostProcessor {

  Map commandMap = new Map();
  String projectInitCommand;
  IObjectFactory objectFactory;
      
  AbstractProject([int priority = 100]) : super(priority) {
  }

  /**
   * Registers Commands with FrontController 
   * You can then access them from anywhere:
   * new RockdotEvent(ProjectEvents.SOME_COMMAND, optionalParamVO, optionalFunctionCallback).dispatch();
   */
  void projectCommands() {
    throw new UnimplementedError("To be implemented in Project subclass");
  }

  void projectInjectors() {
    throw new UnimplementedError("To be implemented in Project subclass");
  }

  /**
   * The screens (read: pages) used by this Project. 
   * In Rockdot Actionscript, these were defined in XML.
   * We have yet to come up with an approach for Dart - XML doesn't make sense.
   * Order of arguments: 
   *                ID            - for property strings. See web/v1/de.properties, for example. 
   *                class         - the screen's class 
   *                tree position - the position of this page in a tree (useful for menus)
   *                tree parent   - the parent of this screens in a tree (useful for menus) 
   *                transition ID - the ID of the page transition effect used by this class (see further down) 
   *                pretty url    - the uri of the page - will result in an anchor, f.ex. www.site.com/#/test
   *                modality      - the page's modality allows you to define your page as a layer
   */
  void projectScreens() {
    throw new UnimplementedError("To be implemented in Project subclass");
  }
  
  /**
   * Define Page Transitions here
   */
  void projectTransitions() {
    throw new UnimplementedError("To be implemented in Project subclass");
  }
  
  void addTransition(String id, Type clazz, num duration, [String transitionType = ScreenConstants.TRANSITION_PARALLEL, num initialAlpha = 0]) {
    dynamic eff = objectFactory.createInstance(clazz, id);
    eff.duration = duration;
    eff.type= transitionType;
    eff.initialAlpha = initialAlpha;
    objectFactory.cache.putInstance(id, eff);
  }
  
  /**
     * Order of arguments: 
     *                ID            - for property strings. See web/v1/de.properties, for example. 
     *                class         - the screen's class 
     *                tree position - the position of this page in a tree (useful for menus)
     *                tree parent   - the parent of this screens in a tree (useful for menus) 
     *                transition ID - the ID of the page transition effect used by this class (see further down) 
     *                pretty url    - the uri of the page - will result in an anchor, f.ex. www.site.com/#/test
     *                modality      - the page's modality allows you to define your page as a layer
     */
  void addScreen(String id, Type clazz, int tree_order, int tree_parent, String transitionID, String url, [String modality = StateConstants.SUB_NORMAL]) {
    RockdotContextHelper.registerScreen( objectFactory, id, clazz, tree_order, tree_parent, transitionID, url, modality);
  }
  void addLayer(String id, Type clazz, int tree_order, int tree_parent, String transitionID, String url) {
    addScreen(id, clazz, tree_order, tree_parent, transitionID, url, StateConstants.SUB_MODAL);
  }

  @override IOperation postProcessObjectFactory(IObjectFactory _objectFactory) {
    objectFactory = _objectFactory;

    projectCommands();
    RockdotContextHelper.registerCommands(objectFactory, commandMap);

    /* Add this Project's Init Command to Bootstrap Command Sequence */
    RockdotConstants.getBootstrap().add(projectInitCommand);
    
    projectInjectors();
    
    projectScreens();

    projectTransitions();

    return null;
  }
}
