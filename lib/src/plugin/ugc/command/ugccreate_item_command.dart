part of rockdot_dart;

	 @retain
class UGCCreateItemCommand extends AbstractUGCCommand {

		@override dynamic execute([RockdotEvent event=null])
		 {
			super.execute(event);

			if (event.data is UGCItemVO) {
				_ugcModel.currentItemDAO = event.data;
			}

			if(_ugcModel.currentItemDAO != null){
				if(_ugcModel.currentItemContainerDAO != null && _ugcModel.currentItemContainerDAO.id != null){
					_ugcModel.currentItemDAO.container_id = _ugcModel.currentItemContainerDAO.id;
				}
				_ugcModel.currentItemDAO.creator_uid = _ugcModel.userDAO.uid;
				amfOperation("UGCEndpoint.createItem", [_ugcModel.currentItemDAO]);
			}
			else{
				dispatchErrorEvent("Nothing to upload. Meh.");
			}


		}
	}
