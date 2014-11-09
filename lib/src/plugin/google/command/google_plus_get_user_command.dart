part of stagexl_rockdot;


@retain
class GooglePlusGetUserCommand extends AbstractGoogleCommand {

  @override
  void execute([XLSignal event = null]) {
    super.execute(event);

    String id = "me";
    if(event.data != null && event.data is String){
      id = event.data;
    }
    
    new PlusApi(_gModel.client).people.get(id)
          .then(_handleResult)
          .catchError(dispatchErrorEvent);
    

    showMessage(getProperty(getProperty("message.google.loading.data")));
  }

  void _handleResult(Person person) {
    hideMessage();
    _gModel.user = person; 
    dispatchCompleteEvent();
  }
}
