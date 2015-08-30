part of stagexl_rockdot.core;


/**
 * @author Nils Doehring
 */
class AbstractBootstrap extends LifecycleSprite {
  RockdotApplicationContext _applicationContext;
  Stage _stage;
  List<IObjectFactoryPostProcessor> plugins = [];
  List<String> propertyFiles = [];

  AbstractBootstrap(Stage stage) : super("rockdot.bootstrap") {
    //XXX currently, LoaderInfo is just a leftover from Actionscript
    LoaderInfo loaderInfo = new LoaderInfo();
    RockdotConstants.setLoaderInfo(loaderInfo);

    _stage = stage;
    enabled = true;
    requiresLoading = true;
  }

  /* Assign and prepare some things for Rockdot */
  @override void init({Map params: null}) {
    super.init(params: params);

    // Instantiate Context.
    _applicationContext = new RockdotApplicationContext(_stage);

    //Feed RockdotConstants 
    RockdotConstants.setStage(_stage);
    RockdotConstants.setContext(_applicationContext);

    //Add property files
    _initPropertyFiles();

    //Add FactoryPostProcessors
    _initPlugins();

    //Logging
    _initLogger();

    onInitComplete();
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
    if (RockdotConstants.DEBUG == false) {
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


  void loadApplicationContext([dynamic data = null]) {
    /** add load listeners */
    _applicationContext.addEventListener(Event.COMPLETE, _onCoreApplicationContextLoadResult);
    _applicationContext.addEventListener(Event.CANCEL, _onCoreApplicationContextLoadFault);

    /** Load */
    _applicationContext.load();
  }


  /**
   * Listener for COMPLETE Event of @see CoreApplicationContext
   * Configures and executes (a as asynchronously) @see CompositeCommandWithEvent
   */
  void _onCoreApplicationContextLoadResult(Event e) {
    logger.info("CoreApplicationContext Loaded...");
    _applicationContext.initApplication(_onCoreApplicationContextInitComplete, _onCoreApplicationContextInitError);
  }

  /**
   * Listener for @see IOErrorEvent of @see CoreApplicationContext
   * * TODO visually display error message
   */
  void _onCoreApplicationContextLoadFault(Event iOErrorEvent) {
    logger.severe("Spring Application Context Failed to Load: [${iOErrorEvent}]");
    throw new StateError("Spring Application Context Failed to Load: [${iOErrorEvent}]");
  }

  /**
   * Listener for COMPLETE Event of @see CompositeCommandWithEvent
   * By now, @see StatePlugin has taken over control.
   */
  void _onCoreApplicationContextInitComplete([OperationEvent event = null]) {
    // All models are loaded. Wiring is done. Extensions are ready. App is ready to go!
    logger.info("Application Context Initialized");

    // App.as listens to ViewEvent.DID_LOAD and will hide AppPreloader and show this
    onLoadComplete();
  }

  /**
   * Listener for ERROR Event of @see CompositeCommandWithEvent
   * TODO visually display error message
   */
  void _onCoreApplicationContextInitError([OperationEvent event = null]) {
    logger.severe("Application Error: ${event.error}");
    throw new StateError("Application Error: ${event.error}");
  }

  @override
  void set enabled(bool value) {
    super.enabled = value;
    mouseChildren = mouseEnabled = value;
  }
}
