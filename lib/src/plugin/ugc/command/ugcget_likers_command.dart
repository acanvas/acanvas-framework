part of rockdot_dart;

	 @retain
class UGCGetLikersCommand extends AbstractUGCCommand {

		@override dynamic execute([RockdotEvent event=null])
		 {
			super.execute(event);

			int currentImageID = (_ugcModel.currentItemDAO.id).toInt();
			UGCFilterVO vo = event.data;
			amfOperation("UGCEndpoint.getLikersOfItem", [{'id':currentImageID, 'limitIndex':vo.limitindex, 'limit':vo.limit}]);

			return null;
		}

		@override bool dispatchCompleteEvent([dynamic event=null])
		 {
			_ugcModel.currentItemDAO.likers = event.result;
			return super.dispatchCompleteEvent(event.result);
		}
	}

