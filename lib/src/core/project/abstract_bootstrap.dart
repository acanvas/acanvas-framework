part of stagexl_rockdot;


/**
   * @author Nils Doehring
   */
class AbstractBootstrap extends ManagedSpriteComponent {
  RockdotApplicationContext _applicationContext;
  Stage _stage;
  List plugins = [];
  List propertyFiles = [];

  AbstractBootstrap(Stage stage) : super() {
    //TODO get loaderInfo config from somewhere (JS?)
    LoaderInfo loaderInfo = new LoaderInfo();
    RockdotConstants.setLoaderInfo(loaderInfo);

    _stage = stage;
    enabled = true;
  }

  @override void init([data = null]) {
    super.init(data);

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

    didInit();
  }
  
  void _initPropertyFiles() {
    IObjectDefinitionsProvider provider = new DefaultObjectDefinitionsProvider();

    for(int i = 0; i<propertyFiles.length;i++){
      TextFileURI uri = new TextFileURI(propertyFiles.elementAt(i), true);
      provider.propertyURIs.add(uri);
    }

    _applicationContext.addDefinitionProvider(provider);
  }
  
  void _initPlugins() {
    
    for(int i = 0; i<plugins.length;i++){
      _applicationContext.addObjectFactoryPostProcessor(plugins.elementAt(i));
    }
    
  }
  
  void _initLogger() {
    if (RockdotConstants.DEBUG == false) {
      //logging.Logger.root.level = logging.Level.OFF;
      print("Logging Disabled. Good Bye.");
    } else {
      logging.Logger.root.level = logging.Level.ALL;
      logging.Logger.root.onRecord.listen((logging.LogRecord rec) {
        print('${rec.level.name}: ${rec.time}: ${rec.message}');
      });

      this.log.info("Logging Enabled. Welcome.");
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
    this.log.info("CoreApplicationContext Loaded...");
    _applicationContext.initApplication(_onCoreApplicationContextInitComplete, _onCoreApplicationContextInitError);
  }

  /**
   * Listener for @see IOErrorEvent of @see CoreApplicationContext
   * TODO Display error message
   */
  void _onCoreApplicationContextLoadFault(Event iOErrorEvent) {
    this.log.severe("Spring Application Context Failed to Load: [" + iOErrorEvent.toString() + "]");
  }

  /**
   * Listener for COMPLETE Event of @see CompositeCommandWithEvent
   * By now, @see StatePlugin has taken over control.
   */
  void _onCoreApplicationContextInitComplete([OperationEvent event = null]) {
    // All models are loaded. Wiring is done. Extensions are ready. App is ready to go!
    this.log.info("Application Context Initialized");

    // App.as listens to ViewEvent.DID_LOAD and will hide AppPreloader and show this
    didLoad();
  }

  /**
   * Listener for ERROR Event of @see CompositeCommandWithEvent
   * TODO visually display error message
   */
  void _onCoreApplicationContextInitError([OperationEvent event = null]) {
    this.log.severe("Application Error: " + event.error);
  }

  @override
  void set enabled(bool value) {
    super.enabled = value;
    mouseChildren = mouseEnabled = value;
  }
}
