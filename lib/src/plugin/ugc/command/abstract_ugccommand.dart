part of rockdot_framework.ugc;

class AbstractUGCCommand extends RdCommand implements IUGCModelAware {
  UGCModel _ugcModel;

  void set ugcModel(UGCModel ugcModel) {
    _ugcModel = ugcModel;
  }

  void amfOperation(String methodName, {IRdDTO dto: null, Map map: null, String json: null}) {
    String params = null;
    if (dto != null) {
      params = JSON.encode(dto);
    } else if (map != null) {
      params = JSON.encode(map);
    } else if (json != null) {
      params = json;
    }

    methodName = methodName.replaceAll(new RegExp(r'UGCEndpoint.|GamingEndpoint.'), '');
    String url = getProperty("project.host.json");
    ServerProxy proxy = new ServerProxy(url);
    proxy.call(methodName, [params]).then((returned) => proxy.checkError(returned)).then((result) {
          // print(result.toString());
          dispatchCompleteEvent(result);
        });
    /*
                 })
         .catchError((error){
      print(error);
      */
  }

  @override
  void errorHandler(OperationEvent event) {
    this.log.error(event.error);
    dispatchCompleteEvent(event.error);
  }
}
