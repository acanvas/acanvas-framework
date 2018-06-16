part of acanvas_framework.ugc;

class AbstractUGCCommand extends AcCommand implements IUGCModelAware {
  UGCModel _ugcModel;

  void set ugcModel(UGCModel ugcModel) {
    _ugcModel = ugcModel;
  }

  void amfOperation(String methodName,
      {IAcDTO dto: null, Map map: null, String json_: null}) {
    String params = null;
    if (dto != null) {
      params = json.encode(dto.toJson());
    } else if (map != null) {
      params = json.encode(map);
    } else if (json != null) {
      params = json_;
    }

    methodName =
        methodName.replaceAll(new RegExp(r'UGCEndpoint.|GamingEndpoint.'), '');
    String url = getProperty("project.host.json");
    ServerProxy proxy = new ServerProxy(url);
    proxy
        .call(methodName, [params])
        .then((returned) => proxy.checkError(returned))
        .then((result) {
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
    this.log.warning(event.error);
    dispatchCompleteEvent(event.error);
  }
}
