part of rockdot_dart;






	 @retain
class UGCLikeCommand extends AbstractUGCCommand {

		@override dynamic execute([RockdotEvent event=null])
		 {
			super.execute(event);
			int id = event.data;
			String uid = _ugcModel.userDAO.uid;

			amfOperation("UGCEndpoint.likeItem", [{id:id, uid:uid}]);
		}
	}

