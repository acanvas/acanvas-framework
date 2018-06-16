part of acanvas_framework.screen;

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
    return AcConstants.getStage();
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
    _background = new LifecycleSprite("acanvas.background");
    _content = new LifecycleSprite("acanvas.content");
    _navi = new LifecycleSprite("acanvas.navigation");
    _layer = new LifecycleSprite("acanvas.layer");
    _foreground = new LifecycleSprite("acanvas.foreground");

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
        AcConstants.WIDTH_STAGE_REAL, AcConstants.HEIGHT_STAGE_REAL);
    _content.span(AcConstants.WIDTH_STAGE_REAL, AcConstants.HEIGHT_STAGE_REAL);
    _navi.span(AcConstants.WIDTH_STAGE_REAL, AcConstants.HEIGHT_STAGE_REAL);
    _layer.span(AcConstants.WIDTH_STAGE_REAL, AcConstants.HEIGHT_STAGE_REAL);
    _foreground.span(
        AcConstants.WIDTH_STAGE_REAL, AcConstants.HEIGHT_STAGE_REAL);

    log.finer("Stage width: {0}, Stage height: {1}",
        [AcConstants.WIDTH_STAGE_REAL, AcConstants.HEIGHT_STAGE_REAL]);

    //new AcSignal(ScreenEvents.RESIZE).dispatch();
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
