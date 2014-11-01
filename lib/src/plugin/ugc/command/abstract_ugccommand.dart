part of stagexl_rockdot;


class AbstractUGCCommand extends CoreCommand implements IUGCModelAware {
  UGCModel _ugcModel;

  void set ugcModel(UGCModel ugcModel) {
    _ugcModel = ugcModel;
  }

  void amfOperation(String methodName, {IXLDTO dto: null, Map map : null, String json : null}) {
   
    String params = null;
    if(dto != null){
      params = JSON.encode(dto);
    }
    else if(map != null){
      params = JSON.encode(map);
    }
    else if(json != null){
      params = json;
    }
    
    methodName = methodName.replaceAll(new RegExp(r'UGCEndpoint.|GamingEndpoint.'), '');
    String url = RockdotConstants.getContext().propertiesProvider.getProperty("project.host.json");
    ServerProxy proxy = new ServerProxy(url);
    proxy.call(methodName, params)
         .then((returned)=>proxy.checkError(returned))
         .then((result){
          // print(result.toString());
           dispatchCompleteEvent(result);
      });
    /*
                 })
         .catchError((error){
      print(error);
      */
   }

  @override void _handleError(OperationEvent event) {
    this.log.error(event.error);
    dispatchCompleteEvent(event.error);
  }
}
