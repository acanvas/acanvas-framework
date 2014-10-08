part of stagexl_rockdot;

	 @retain
class TaskGetTasksByCategoryCommand extends AbstractUGCCommand {

		@override dynamic execute([RockdotEvent event=null])
		 {
			super.execute(event);
			amfOperation("UGCEndpoint.getTasksOfCategory", event.data);
		}
		
		
		@override bool dispatchCompleteEvent([dynamic result=null])
		 {
			_ugcModel.loadedTasks = result.result;
			return super.dispatchCompleteEvent(result.result);
		}
	}

