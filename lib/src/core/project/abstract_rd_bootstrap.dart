part of rockdot_framework.core;

/**
 * @author Nils Doehring
 */
class AbstractRdBootstrap extends EventDispatcher {
  logging.Logger logger = new logging.Logger("rockdot.bootstrap");
  RdContext _applicationContext;
  Stage _stage;
  List<IObjectFactoryPostProcessor> plugins = [];
  List<String> propertyFiles = [];

  AbstractRdBootstrap(Stage stage) {
    //XXX currently, LoaderInfo is just a leftover from Actionscript
    LoaderInfo loaderInfo = new LoaderInfo();
    RdConstants.setLoaderInfo(loaderInfo);

    _stage = stage;
  }

  /* Assign and prepare some things for Rockdot */
  void init() {
    // Instantiate Context.
    _applicationContext = new RdContext(_stage);

    //Feed RockdotConstants
    RdConstants.setStage(_stage);
    RdConstants.setContext(_applicationContext);

    //Add property files
    _initPropertyFiles();

    //Add FactoryPostProcessors
    _initPlugins();

    //Logging
    _initLogger();
  }

  void _initPropertyFiles() {
    IObjectDefinitionsProvider provider = new DefaultObjectDefinitionsProvider();

    propertyFiles.forEach((file) {
      TextFileURI uri = new TextFileURI(file, true);
      provider.propertyURIs.add(uri);
    });

    _applicationContext.addDefinitionProvider(provider);
  }

  void _initPlugins() {
    plugins.forEach((plugin) {
      _applicationContext.addObjectFactoryPostProcessor(plugin);
    });
  }

  void _initLogger() {
    if (RdConstants.DEBUG == false) {
      logging.Logger.root.level = logging.Level.OFF;
      print("Logging Disabled. Good Bye.");
    } else {
      logging.Logger.root.level = logging.Level.ALL;
      logging.Logger.root.onRecord.listen((logging.LogRecord rec) {
        print('${rec.level.name}: ${rec.time}: ${rec.message}');
      });

      logger.info("Logging Enabled. Welcome.");
    }
  }

  Future loadApplicationContext() async {
    /** add load listeners */
    // _applicationContext.addEventListener(Event.CANCEL, _onCoreApplicationContextLoadFault);
    /** Load */
    await _applicationContext.load().catchError((e) {
      logger.severe("Spring Application Context Failed to Load: [${e}]");
      throw new StateError("Spring Application Context Failed to Load: [${e}]");
    });

    logger.info("CoreApplicationContext Loaded...");
    await _applicationContext.initApplication().catchError((e) {
      logger.severe("Application Error: ${e}");
      throw new StateError("Application Error: ${e}");
    });

    logger.info("Application Context Initialized");
  }
}
