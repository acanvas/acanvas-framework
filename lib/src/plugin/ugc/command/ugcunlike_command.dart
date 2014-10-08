part of stagexl_rockdot;






	 @retain
class UGCUnlikeCommand extends AbstractUGCCommand {

		@override dynamic execute([RockdotEvent event=null])
		 {
			super.execute(event);
			int id = (event.data as UGCRatingVO).id;
			String uid = _ugcModel.userDAO.uid;

			amfOperation("UGCEndpoint.unlikeItem", [{id:id, uid:uid}]);
		}
	}

