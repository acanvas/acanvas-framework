part of rockdot_framework.screen;

/**
 * @author nilsdoehring
 */
class AbstractScreenService implements IScreenService {
  Logger log = new Logger("IScreenService");

  /**
   * GETTER AND SETTER
   */
  LifecycleSprite _background;

  LifecycleSprite get background {
    return _background;
  }

  LifecycleSprite _content;

  LifecycleSprite get content {
    return _content;
  }

  LifecycleSprite _navi;

  LifecycleSprite get navi {
    return _navi;
  }

  LifecycleSprite _layer;

  LifecycleSprite get layer {
    return _layer;
  }

  LifecycleSprite _foreground;

  LifecycleSprite get foreground {
    return _foreground;
  }

  Stage get stage {
    return RdConstants.getStage();
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

  void set isBlurred(bool blurred) {
    _isBlurred = blurred;
  }

  AbstractScreenService() {
    _initialized = false;
    _isBlurred = false;
  }

  void init([Function callback = null]) {
    _background = new LifecycleSprite("rockdot.background");
    _content = new LifecycleSprite("rockdot.content");
    _navi = new LifecycleSprite("rockdot.navigation");
    _layer = new LifecycleSprite("rockdot.layer");
    _foreground = new LifecycleSprite("rockdot.foreground");

    stage.addChild(_background);
    stage.addChild(_content);
    stage.addChild(_navi);
    stage.addChild(_layer);
    stage.addChild(_foreground);

    resize();

    _background.init();
    _background.onInitComplete();
    _content.init();
    _content.onInitComplete();
    _navi.init();
    _navi.onInitComplete();
    _layer.init();
    _layer.onInitComplete();
    _foreground.init();
    _foreground.onInitComplete();

    if (callback != null) {
      callback();
    }

    stage.addEventListener(Event.RESIZE, resize);
  }

  void resize([Event event = null]) {
    _background.span(
        RdConstants.WIDTH_STAGE_REAL, RdConstants.HEIGHT_STAGE_REAL);
    _content.span(RdConstants.WIDTH_STAGE_REAL, RdConstants.HEIGHT_STAGE_REAL);
    _navi.span(RdConstants.WIDTH_STAGE_REAL, RdConstants.HEIGHT_STAGE_REAL);
    _layer.span(RdConstants.WIDTH_STAGE_REAL, RdConstants.HEIGHT_STAGE_REAL);
    _foreground.span(
        RdConstants.WIDTH_STAGE_REAL, RdConstants.HEIGHT_STAGE_REAL);

    log.finer("Stage width: {0}, Stage height: {1}",
        [RdConstants.WIDTH_STAGE_REAL, RdConstants.HEIGHT_STAGE_REAL]);

    //new RdSignal(ScreenEvents.RESIZE).dispatch();
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
