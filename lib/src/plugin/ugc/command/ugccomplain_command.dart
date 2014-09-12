part of rockdot_dart;


	 @retain
class UGCComplainCommand extends AbstractUGCCommand {

		@override dynamic execute([RockdotEvent event=null])
		 {
			super.execute(event);

			int id = event.data;
			String uid = _ugcModel.userDAO.uid;

			amfOperation("UGCEndpoint.complainItem", [{id:id, uid:uid}]);

			return null;
		}
	}

