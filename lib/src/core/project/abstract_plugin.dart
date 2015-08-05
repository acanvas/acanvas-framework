part of stagexl_rockdot.core;

class AbstractPlugin extends AbstractOrderedFactoryPostProcessor {

  Map commandMap = new Map();
  String projectInitCommand;
  IObjectFactory objectFactory;

  AbstractPlugin([int priority = 100]) : super(priority) {
  }

  /**
   * Registers Commands with FrontController
   * You can then access them from anywhere:
   * new XLSignal(ProjectEvents.SOME_COMMAND, optionalParamVO, optionalFunctionCallback).dispatch();
   */
  void configureCommands() {
    throw new UnimplementedError("To be implemented in Project subclass");
  }

  void configureInjectors() {
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
  void configureScreens() {
    //throw new UnimplementedError("To be implemented in Project subclass");
  }

  /**
   * Define Page Transitions here
   */
  void configureTransitions() {
    //throw new UnimplementedError("To be implemented in Project subclass");
  }

  void addTransition(String id, IEffect eff, num duration, [String transitionType = ScreenConstants.TRANSITION_PARALLEL, num initialAlpha = 0]) {
    eff.duration = duration;
    eff.type = transitionType;
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
  void addScreen(String id, Function func,
                 {String url, String substate : StateConstants.SUB_NORMAL, int tree_order : 0, int tree_parent : 0, String transition : "transition.default"}) {
    url = url == null ? objectFactory.propertiesProvider.getProperty("$id.url") : url;
    RockdotContextHelper.registerScreen(objectFactory, id, func, url, tree_order: tree_order, tree_parent: tree_parent, transition: transition, substate: substate);
  }

  void addScreenInstance(RockdotLifecycleSprite clazz,
                         {String url: null, String substate : StateConstants.SUB_NORMAL, int tree_order : 0, int tree_parent : 0, String transition : "transition.default"}) {
    url = url == null ? objectFactory.propertiesProvider.getProperty("${clazz.name}.url") : url;
    RockdotContextHelper.registerScreenInstance(objectFactory, clazz.name, clazz, url, tree_order: tree_order, tree_parent: tree_parent, transition: transition, substate: substate);
  }

  void addLayer(String id, Function func,
                {String url, int tree_order : 0, int tree_parent : 0, String transition : "transition.default.modal"}) {
    addScreen(id, func, url: url, tree_order: tree_order, tree_parent: tree_parent, transition: transition, substate: StateConstants.SUB_MODAL);
  }

  void addLayerInstance(RockdotLifecycleSprite clazz,
                        {String url, int tree_order : 0, int tree_parent : 0, String transition : "transition.default.modal"}) {
    addScreenInstance(clazz, url: url, tree_order: tree_order, tree_parent: tree_parent, transition: transition, substate: StateConstants.SUB_MODAL);
  }

  @override IOperation postProcessObjectFactory(IObjectFactory _objectFactory) {
    objectFactory = _objectFactory;

    configureCommands();
    RockdotContextHelper.registerCommands(objectFactory, commandMap);

    /* Add this Project's Init Command to Bootstrap Command Sequence */
    if (projectInitCommand != null) {
      RockdotConstants.getBootstrap().add(projectInitCommand);
    }

    configureInjectors();

    configureScreens();

    configureTransitions();

    return null;
  }
}
