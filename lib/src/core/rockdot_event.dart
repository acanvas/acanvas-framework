part of rockdot_dart;

class RockdotEvent extends Event{
  var _callback;
  var _data;
  final DartEventBus eventBus = new DartEventBus();
  
  RockdotEvent(String type, [this._data = null, this._callback = null]) : super(type);
  
  void dispatch(){
    eventBus.dispatchEvent(new RockdotEvent(type, _data, _callback));
  }
  void listen(){
    eventBus.addEventListener(type , _callback);
  }
  void unlisten(){
    eventBus.removeEventListener(type , _callback);
  }

  get data => _data;
  get completeCallBack => _callback;
 }