part of stagexl_rockdot;

@retain
class TaskGetTasksByCategoryCommand extends AbstractUGCCommand {

  @override void execute([RockdotEvent event = null]) {
    super.execute(event);

    Map dto = {
      'id': event.data
    };

    amfOperation("UGCEndpoint.getTasksOfCategory", dto);
  }


  @override bool dispatchCompleteEvent([dynamic result = null]) {
    _ugcModel.loadedTasks = result.result;
    return super.dispatchCompleteEvent(result.result);
  }
}
