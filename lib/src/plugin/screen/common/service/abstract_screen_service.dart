part of stagexl_rockdot;


/**
	 * @author nilsdoehring
	 */
class AbstractScreenService implements IScreenService {

  Logger log = new Logger("IScreenService");

  /**
		 * GETTER AND SETTER
		 */
  ManagedSpriteComponent _background;
  ManagedSpriteComponent get background {
    return _background;
  }

  ManagedSpriteComponent _content;
  ManagedSpriteComponent get content {
    return _content;
  }

  ManagedSpriteComponent _navi;
  ManagedSpriteComponent get navi {
    return _navi;
  }

  ManagedSpriteComponent _layer;
  ManagedSpriteComponent get layer {
    return _layer;
  }

  ManagedSpriteComponent _foreground;
  ManagedSpriteComponent get foreground {
    return _foreground;
  }
  Stage get stage {
    return RockdotConstants.getStage();
  }

  bool _initialized;
  bool get initialized {
    return _initialized;
  }

  BitmapFilter _filter;
  BitmapFilter get modalBackgroundFilter {
    return _filter;
  }
  void set modalBackgroundFilter(BitmapFilter filter) {
    _filter = filter;
  }
  
  bool _isBlurred;
  bool get isBlurred => _isBlurred;
  void set isBlurred(bool blurred){
    _isBlurred = blurred;
  }
  
  AbstractScreenService() {
    _initialized = false;
    _isBlurred = false;
  }
  void init([Function callback = null]) {

    _background = new ManagedSpriteComponent();
    _content = new ManagedSpriteComponent();
    _navi = new ManagedSpriteComponent();
    _layer = new ManagedSpriteComponent();
    _foreground = new ManagedSpriteComponent();

    stage.addChild(_background);
    stage.addChild(_content);
    stage.addChild(_navi);
    stage.addChild(_layer);
    stage.addChild(_foreground);

    _initialized = true;

    if (callback != null) {
      callback();
    }

    resize();
    stage.addEventListener(Event.RESIZE, resize);
  }

  void resize([Event event = null]) {

    _background.setSize(RockdotConstants.WIDTH_STAGE_REAL, RockdotConstants.HEIGHT_STAGE_REAL);
    _content.setSize(RockdotConstants.WIDTH_STAGE_REAL, RockdotConstants.HEIGHT_STAGE_REAL);
    _navi.setSize(RockdotConstants.WIDTH_STAGE_REAL, RockdotConstants.HEIGHT_STAGE_REAL);
    _layer.setSize(RockdotConstants.WIDTH_STAGE_REAL, RockdotConstants.HEIGHT_STAGE_REAL);
    _foreground.setSize(RockdotConstants.WIDTH_STAGE_REAL, RockdotConstants.HEIGHT_STAGE_REAL);

    log.finer("Stage width: ${RockdotConstants.WIDTH_STAGE_REAL}, Stage height: ${RockdotConstants.HEIGHT_STAGE_REAL}");

    //new XLSignal(ScreenEvents.RESIZE).dispatch();

  }
  void lock() {
    _content.mouseEnabled = false;
    _content.mouseChildren = false;
  }
  void unlock() {
    _content.mouseEnabled = true;
    _content.mouseChildren = true;
  }
  
  void blur() {
    _content.enabled = false;
    _background.enabled = false;

    // blur background/content
    if (modalBackgroundFilter != null) {
      _content.filters = [modalBackgroundFilter];
      if (_background.numChildren > 0) {
        _background.filters = [modalBackgroundFilter];
      }
    }
    _isBlurred = true;
  }

  void unblur() {
    _content.enabled = true;
    _background.enabled = true;
    // unblur background/content
    _content.filters = [];
    _background.filters = [];
    _isBlurred = false;
  }
  
  
}
