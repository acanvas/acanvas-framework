part of rockdot_dart;

class ManagedSpriteComponentEvent extends Event {

  static const String INIT_START = "ViewEvent.WILL_INIT";
  static const String INIT_COMPLETE = "ViewEvent.DID_INIT";

  static const String LOAD_START = "ViewEvent.WILL_LOAD";
  static const String LOAD_COMPLETE = "ViewEvent.DID_LOAD";
  static const String LOAD_ERROR = "ViewEvent.LOAD_ERROR";

  static const String APPEAR_START = "ViewEvent.WILL_APPEAR";
  static const String APPEAR_COMPLETE = "ViewEvent.DID_APPEAR";

  static const String DISAPPEAR_START = "ViewEvent.WILL_DISAPPEAR";
  static const String DISAPPEAR_COMPLETE = "ViewEvent.DID_DISAPPEAR";

  static const String DESTROY_START = "ViewEvent.WILL_DESTROY";
  static const String DESTROY_COMPLETE = "ViewEvent.DID_DESTROY";

  static const String WILL_ACTIVATE = "ViewEvent.WILL_ACTIVATE";
  static const String DID_ACTIVATE = "ViewEvent.DID_ACTIVATE";
  static const String WILL_DEACTIVATE = "ViewEvent.WILL_DEACTIVATE";
  static const String DID_DEACTIVATE = "ViewEvent.DID_DEACTIVATE";

  var _data;
  
  ManagedSpriteComponentEvent(String type, [this._data = null, bool bubbles = false]) : super(type, bubbles);
  
  //@override
  //Event clone() => new ManagedSpriteComponentEvent(type, _data, bubbles);
}
