part of rockdot_dart;




/**
	 * @author nilsdoehring
	 */
class AbstractScreenService implements IScreenService {

  RockdotLogger log = new RockdotLogger("IScreenService");

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
  AbstractScreenService() {
    _initialized = false;
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

    _background.setSize(RockdotConstants.WIDTH_STAGE, RockdotConstants.HEIGHT_STAGE);
    _content.setSize(RockdotConstants.WIDTH_STAGE, RockdotConstants.HEIGHT_STAGE);
    _navi.setSize(RockdotConstants.WIDTH_STAGE, RockdotConstants.HEIGHT_STAGE);
    _layer.setSize(RockdotConstants.WIDTH_STAGE, RockdotConstants.HEIGHT_STAGE);
    _foreground.setSize(RockdotConstants.WIDTH_STAGE, RockdotConstants.HEIGHT_STAGE);

    log.finer("Stage width: ${RockdotConstants.WIDTH_STAGE}, Stage height: ${RockdotConstants.HEIGHT_STAGE}");

    new RockdotEvent(ScreenEvents.RESIZE).dispatch();

  }
  void lock() {
    _content.mouseEnabled = false;
    _content.mouseChildren = false;
  }
  void unlock() {
    _content.mouseEnabled = true;
    _content.mouseChildren = true;
  }
}
