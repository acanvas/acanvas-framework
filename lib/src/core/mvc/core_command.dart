part of stagexl_rockdot;



class CoreCommand extends AbstractOperation implements IAsyncCommand, IApplicationContextAware {
  Logger log;

  XLSignal _event;
  Function _callback;

  CoreCommand() {
    log = new Logger(this.toString());
  }

  String getProperty(String key) {
    String str = _context.propertiesProvider.getProperty(key);
    if (str == null) {
      str = key;
    }
    return str;
  }

  IApplicationContext _context;
  IApplicationContext get applicationContext {
    return _context;
  }
  void set applicationContext(IApplicationContext value) {
    _context = value;
  }


  @override bool dispatchCompleteEvent([dynamic result = null]) {
    if (result != null && result is OperationEvent) {
      result = result.result;
    }
    if (_callback != null) {
      (result != null) ? _callback.call(result) : _callback.call();
      _callback = null;
    }
    return super.dispatchCompleteEvent(result);
  }
  void _handleError(OperationEvent event) {
    log.severe(event.error);
    dispatchErrorEvent(event.error);
  }

  void execute([XLSignal event = null]) {
    _event = event;
    if (event != null && event.completeCallBack != null) {
      _callback = event.completeCallBack;
    }
  }

  void showMessage(String message, {int timeBox: 0, int type: StateMessageVO.TYPE_INFO, bool blur: false}) {
    String id = (_event == null) ? "NO_ID" : _event.type;
    new XLSignal(StateEvents.MESSAGE_SHOW, new StateMessageVO(id, message, timeBox, type: type, blurContent: blur)).dispatch();
  }

  void hideMessage([String id = null]) {
    String id = (_event == null) ? "NO_ID" : _event.type;
    new XLSignal(StateEvents.MESSAGE_HIDE, id).dispatch();
  }

}
