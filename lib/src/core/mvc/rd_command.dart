part of rockdot_framework.core;


class RdCommand extends AbstractOperation implements IAsyncCommand, IApplicationContextAware {
  Logger log;

  RdSignal _event;
  Function _callback;

  RdCommand() {
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

  @override IApplicationContext get applicationContext {
    return _context;
  }

  @override void set applicationContext(IApplicationContext value) {
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

  @override void errorHandler(OperationEvent event) {
    log.severe(event.error);
    dispatchErrorEvent(event.error);
  }

  @override void execute([RdSignal event = null]) {
    _event = event;
    if (event != null && event.completeCallBack != null) {
      _callback = event.completeCallBack;
    }
  }

  void showMessage(String message, {int timeBox: 0, int type: StateMessageVO.TYPE_INFO, bool blur: false}) {
    String id = (_event == null) ? "NO_ID" : _event.type;
    new RdSignal(StateEvents.MESSAGE_SHOW, new StateMessageVO(id, message, timeBox, type: type, blurContent: blur)).dispatch();
  }

  void hideMessage([String id = null]) {
    String id = (_event == null) ? "NO_ID" : _event.type;
    new RdSignal(StateEvents.MESSAGE_HIDE, id).dispatch();
  }

}
