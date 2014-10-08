part of stagexl_rockdot;






	 @retain
class GamingCheckPermissionToPlayCommand extends AbstractUGCCommand{

		@override dynamic execute([RockdotEvent event=null])
		 {
			super.execute(event);
			amfOperation("GamingEndpoint.checkPermissionToPlay", [_ugcModel.userDAO.uid]);
		}


		@override bool dispatchCompleteEvent([dynamic result=null])
		 {
			_ugcModel.gaming.allowedToPlay = result.result;
			return super.dispatchCompleteEvent(_ugcModel.gaming.allowedToPlay);
		}
	}

