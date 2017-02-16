part of rockdot_framework.ugc;

//@retain
class TaskGetTasksByCategoryCommand extends AbstractUGCCommand {
  @override
  void execute([RdSignal event = null]) {
    super.execute(event);

    Map dto = {'id': event.data};

    amfOperation("UGCEndpoint.getTasksOfCategory", map: dto);
  }

  @override
  bool dispatchCompleteEvent([dynamic result = null]) {
    _ugcModel.loadedTasks = result.result;
    return super.dispatchCompleteEvent(result.result);
  }
}
