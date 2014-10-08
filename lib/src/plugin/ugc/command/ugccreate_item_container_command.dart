part of stagexl_rockdot;

	 @retain
class UGCCreateItemContainerCommand extends AbstractUGCCommand {

		@override dynamic execute([RockdotEvent event=null])
		 {
			super.execute(event);
			if (event.data is UGCItemContainerVO) {
				_ugcModel.currentItemContainerDAO = event.data;
			}
			amfOperation("UGCEndpoint.createItemContainer", [_ugcModel.currentItemContainerDAO]);
		}


		@override bool dispatchCompleteEvent([dynamic result=null])
		 {
			_ugcModel.currentItemContainerDAO.id = result.result;
			if(_ugcModel.currentItemDAO != null){
				_ugcModel.currentItemDAO.container_id = result.result;
			}
			return super.dispatchCompleteEvent(result);
		}
	}

