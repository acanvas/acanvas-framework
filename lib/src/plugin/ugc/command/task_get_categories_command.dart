part of stagexl_rockdot;

@retain
class TaskGetCategoriesCommand extends AbstractUGCCommand {

  @override void execute([XLSignal event = null]) {
    super.execute(event);
   
    amfOperation("UGCEndpoint.getTaskCategories");
  }


  @override bool dispatchCompleteEvent([dynamic result = null]) {
    _ugcModel.taskCategories = result.result;
    return super.dispatchCompleteEvent(_ugcModel.taskCategories);
  }
}
