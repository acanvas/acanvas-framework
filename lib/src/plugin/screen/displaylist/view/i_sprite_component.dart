part of rockdot_dart;

abstract class ISpriteComponent extends EventDispatcher {

  void setSize(num w, num h);

  void destroy();
  void appear([double duration = 0.5]);
  void disappear([double duration = 0.5, bool autoDestroy = false]);

  void redraw();

  num get widthAsSet;
  void set widthAsSet(num w);

  num get heightAsSet;
  void set heightAsSet(num h);

  bool get enabled;
  void set enabled(bool enabled);

  bool get ignoreSetEnabled;
  void set ignoreSetEnabled(bool enabled);

  bool get ignoreSetTouchEnabled;
  void set ignoreSetTouchEnabled(bool enabled);

  bool get ignoreCallSetSize;
  void set ignoreCallSetSize(bool enabled);

  bool get ignoreCallDestroy;
  void set ignoreCallDestroy(bool enabled);

  /* IDisplayObject*/
  num get alpha;
  void set alpha(num w);

  Stage get stage;
}
