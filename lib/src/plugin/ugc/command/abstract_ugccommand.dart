part of stagexl_rockdot;


class AbstractUGCCommand extends CoreCommand implements IUGCModelAware {
  UGCModel _ugcModel;

  void set ugcModel(UGCModel ugcModel) {
    _ugcModel = ugcModel;
  }

  void amfOperation(String string, [Map params = null]) {
    IOperation operation = new PersistenceOperation(_ugcModel.service, string, params);
    operation.addCompleteListener(dispatchCompleteEvent);
    operation.addErrorListener(_handleError);
  }

  @override void _handleError(OperationEvent event) {
    this.log.error(event.error);
    dispatchCompleteEvent(event.error);
  }
}
