part of rockdot_framework.ugc;

class TaskGetCategoriesCommand extends AbstractUGCCommand {
  @override
  void execute([RdSignal event = null]) {
    super.execute(event);

    amfOperation("UGCEndpoint.getTaskCategories");
  }

  @override
  bool dispatchCompleteEvent([dynamic result = null]) {
    _ugcModel.taskCategories = result;
    return super.dispatchCompleteEvent(_ugcModel.taskCategories);
  }
}
