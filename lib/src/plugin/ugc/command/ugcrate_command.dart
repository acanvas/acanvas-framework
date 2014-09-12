part of rockdot_dart;






	 @retain
class UGCRateCommand extends AbstractUGCCommand {

		@override dynamic execute([RockdotEvent event=null])
		 {
			super.execute(event);
			UGCRatingVO vo = event.data;
			String uid = _ugcModel.userDAO.uid;

			amfOperation("UGCEndpoint.rateItem", [{'id':vo.id, 'rating':vo.rating, 'uid':uid}]);
		}
	}

