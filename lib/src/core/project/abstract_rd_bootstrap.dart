part of rockdot_framework.core;

/**
 * @author Nils Doehring
 */
class AbstractRdBootstrap extends EventDispatcher {
  Logger logger = Rd.log;
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
      Logger.root.level = Level.OFF;
      print("Logging Disabled. Good Bye.");
    } else {
      Logger.root.level = Level.ALL;
      Logger.root.onRecord.listen((LogRecord rec) {
        String msg = rec.message;
        if(rec.error is List){
          for(int i=0;i<(rec.error as List).length;i++){
            msg = msg.replaceFirst("{$i}", (rec.error as List)[i].toString());
          }
        }
        print('${rec.level.name}: ${rec.time}: ${msg}');
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
