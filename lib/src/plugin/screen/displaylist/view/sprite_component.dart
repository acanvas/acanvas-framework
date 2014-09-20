part of rockdot_dart;

class SpriteComponent extends Sprite implements ISpriteComponent {
  num _widthAsSet = 0;
  num _heightAsSet = 0;

  bool _enabled = false;
  bool _ignoreSetEnabled = false;
  bool _ignoreSetTouchEnabled = false;
  bool _ignoreCallDestroy = false;
  bool _ignoreCallSetSize = true;

  //TODO logger
  Logger log;

  //events
  RockdotEvent _submitEvent;
  Function _submitCallback;
  List _submitCallbackParams;

  SpriteComponent() {
    this.log = new Logger(reflect(this).type.qualifiedName.toString());
  }

  @override
  void addChild(DisplayObject child) {
    super.addChild(child);
    if (child is ISpriteComponent) {
      if (!(child as ISpriteComponent).ignoreSetEnabled && this.enabled) {
        (child as ISpriteComponent).enabled = true;
      }
    }
  }

  @override
  void setSize(num w, num h) {
    if (w != _widthAsSet || h != _heightAsSet) {
      if (w > 0) _widthAsSet = w;
      if (h > 0) _heightAsSet = h;
      if (!(this is IManagedSpriteComponent) || (this is IManagedSpriteComponent && (this as IManagedSpriteComponent).getInitialized())) {
        // if IView, only render if already initialized
        redraw();
      }

      DisplayObject child;
      for (int i = 0; i < numChildren; i++) {
        child = getChildAt(i);
        if (child is ISpriteComponent && !(child as ISpriteComponent).ignoreCallSetSize) {
          (child as ISpriteComponent).setSize(w, h);
        }
        // if (child is TextField) TextField(child).width = w - 10;
      }
    }


  }

  @override
  void redraw() {
    // implement in subclass
  }

  @override
  void appear([double duration = 0.5]) {
    DisplayObject child;
    for (int i = 0; i < numChildren; i++) {
      child = getChildAt(i);
      if (child is ISpriteComponent) {
        (child as ISpriteComponent).appear(duration);
      }
    }
  }

  @override
  void disappear([double duration = 0.5, bool autoDestroy = false]) {
    DisplayObject child;
    for (int i = 0; i < numChildren; i++) {
      child = getChildAt(i);
      if (child is ISpriteComponent) {
        (child as ISpriteComponent).disappear(duration, autoDestroy);
      }
    }
  }

  @override
  void destroy() {
    while (numChildren > 0) {
      disposeChild(getChildAt(numChildren - 1));
    }
  }

  void disposeChild([DisplayObject dobj = null]) {
    if (dobj != null) {

      if (dobj is ISpriteComponent && !(dobj as ISpriteComponent).ignoreCallDestroy && dobj != this) {
        (dobj as ISpriteComponent).destroy();
       // dobj = null;
       // return;
      }
      if (dobj.parent != null) {
        dobj.parent.removeChild(dobj);
      }
      if (dobj is Bitmap) {
        dobj.bitmapData.clear();
      }
      if (dobj is BitmapData) {
        (dobj as BitmapData).clear();
      }
      if (dobj is Shape) {
        dobj.graphics.clear();
      }
      if (dobj is Sprite) {
        dobj.graphics.clear();
      }
      dobj = null;
    }
  }


/* GETTERS/SETTERS */

  num get widthAsSet => _widthAsSet;

  void set widthAsSet(num w) {
    setSize(w, _heightAsSet);
  }

  num get heightAsSet => _heightAsSet;

  void set heightAsSet(num h) {
    setSize(_widthAsSet, h);
  }

  @override
  bool get enabled => _enabled;

  @override
  void set enabled(bool enabled) {
    if(_enabled == enabled){
      return;
    }
    
    _enabled = enabled;

    DisplayObject child;
    for (int i = 0; i < numChildren; i++) {
      child = getChildAt(i);
      if (child is ISpriteComponent && !(child as ISpriteComponent).ignoreSetEnabled) {
        (child as ISpriteComponent).enabled = _enabled;
      }
    }
  }


  @override
  void set ignoreCallDestroy(bool enabled) {
    _ignoreCallDestroy = enabled;
  }


  void set submitEvent(RockdotEvent submitEvent) {
    _submitEvent = submitEvent;
  }

  Function get submitCallback => _submitCallback;
  void set submitCallback(Function submitCallback) {
    _submitCallback = submitCallback;
  }

  void set submitCallbackParams(List submitCallbackParams) {
    _submitCallbackParams = submitCallbackParams;
  }

  @override
  bool get ignoreCallDestroy => _ignoreCallDestroy;

  @override
  void set ignoreCallSetSize(bool enabled) {
   _ignoreCallSetSize = enabled;
  }

  @override
  bool get ignoreCallSetSize => _ignoreCallSetSize;

  @override
  void set ignoreSetEnabled(bool enabled) {
    _ignoreSetEnabled  = enabled;
  }

  @override
  bool get ignoreSetEnabled => _ignoreSetEnabled;

  @override
  bool get ignoreSetTouchEnabled => _ignoreSetTouchEnabled;

  @override
  void set ignoreSetTouchEnabled(bool enabled) {
    _ignoreSetTouchEnabled = enabled;
  }
}
