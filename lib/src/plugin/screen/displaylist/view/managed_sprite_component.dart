part of rockdot_dart;


class ManagedSpriteComponent extends SpriteComponent implements IManagedSpriteComponent {
  var _data;
  bool _initialized = false;
  bool _loaded = false;
  bool _appeared = false;
  bool _disappeared = false;
  bool _destroyed = false;

  ManagedSpriteComponent([String id = ""]) {
    if(id == ""){
      name = reflect(this).type.qualifiedName.toString();
    }
    else{
      name = id;
    }
  }


  @override
  bool getInitialized() => _initialized;

  @override
  bool getLoaded() => _loaded;

  bool getAppeared() => _appeared;
  bool getDisappeared() => _disappeared;
  bool getDestroyed() => _destroyed;


  @override
  void addChild(DisplayObject child) {
    if (child is IManagedSpriteComponent) {
      if (this._initialized) {
        (child as IManagedSpriteComponent).init(_data);
      }
    }
    return super.addChild(child);
  }

  @override
  void init([data = null]) {
    _data = data;
    dispatchEvent(new ManagedSpriteComponentEvent(ManagedSpriteComponentEvent.INIT_START));
  }

  void didInit() {
    _initialized = true;
    _destroyed = false;
    redraw();
    dispatchEvent(new ManagedSpriteComponentEvent(ManagedSpriteComponentEvent.INIT_COMPLETE));
  }

  @override
  void load([data = null]) {
    dispatchEvent(new ManagedSpriteComponentEvent(ManagedSpriteComponentEvent.LOAD_START));
  }

  void didLoad() {
    _loaded = true;
    //_log.debug("did load");
    dispatchEvent(new ManagedSpriteComponentEvent(ManagedSpriteComponentEvent.LOAD_COMPLETE));
  }

  void _onLoadError(String errorMessage) {
    _loaded = false;
    //_log.debug("onLoadError. " + errorMessage);
    dispatchEvent(new ManagedSpriteComponentEvent(ManagedSpriteComponentEvent.LOAD_ERROR, errorMessage));
  }

  @override
  void appear([num duration = 0.5]) {
    //_log.debug("appear: " + duration + " seconds");
    dispatchEvent(new ManagedSpriteComponentEvent(ManagedSpriteComponentEvent.APPEAR_START));
  }

  void onAppear() {
    _appeared = true;
    _disappeared = false;
    //_log.debug("did appear");
    dispatchEvent(new ManagedSpriteComponentEvent(ManagedSpriteComponentEvent.APPEAR_COMPLETE));
  }

  @override
  void disappear([num duration = 0.5, bool autoDestroy = false]) {
    // _log.debug("disappear: " + duration + " seconds. Autodestroy: " + autoDestroy);
    if (autoDestroy) addEventListener(ManagedSpriteComponentEvent.DISAPPEAR_COMPLETE, _autoDestroy);
    dispatchEvent(new ManagedSpriteComponentEvent(ManagedSpriteComponentEvent.DISAPPEAR_START));
  }

  void onDisappear() {
    _disappeared = true;
    _appeared = false;
    // _log.debug("did disappear");
    dispatchEvent(new ManagedSpriteComponentEvent(ManagedSpriteComponentEvent.DISAPPEAR_COMPLETE));
  }

  @override
  void destroy() {
    // _log.debug("destroy");
    dispatchEvent(new ManagedSpriteComponentEvent(ManagedSpriteComponentEvent.DESTROY_START));
    // Will destroy all IComponent children
    super.destroy();
  }

  void _autoDestroy(ManagedSpriteComponentEvent event) {
    destroy();
  }

  void _didDestroy() {
    if (parent != null) parent.removeChild(this);
    _destroyed = true;
    _initialized = false;
    // removeEventListener(ViewEvent.DID_DISAPPEAR, destroy);
    //_log.debug("did destroy");
    dispatchEvent(new ManagedSpriteComponentEvent(ManagedSpriteComponentEvent.DESTROY_COMPLETE));
  }

  @override
  void setData(data) {
    _data = data;
  }
}
