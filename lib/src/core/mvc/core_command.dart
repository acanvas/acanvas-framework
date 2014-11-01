part of stagexl_rockdot;



class CoreCommand extends AbstractOperation implements IAsyncCommand, IApplicationContextAware {
  Logger log;

  Function _callback;

  CoreCommand() {
    log = new Logger(this.toString());
  }

  String getProperty(String key) {
    return _context.propertiesProvider.getProperty(key);
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
      _callback.call(result);
      _callback = null;
    }
    return super.dispatchCompleteEvent(result);
  }
  void _handleError(OperationEvent event) {
    log.severe(event.error);
    dispatchErrorEvent(event.error);
  }

  void execute([XLSignal event = null]) {
    if (event != null && event.completeCallBack != null) {
      _callback = event.completeCallBack;
    }
  }

  //TODO void dispatchMessage(String string)
  // {
  //	log.info("Message: " + string);
//			new BaseEvent(StateEvents.ADDRESS_SET, string).dispatch();
  //	}
  //TODO void hideMessage(String string)
  // {
//			new BaseEvent(StateEvents.ADDRESS_UNSET, string).dispatch();
  //	}


}
