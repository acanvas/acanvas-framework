part of rockdot_dart;






	 @retain
class GamingCheckPermissionToPlayLocaleCommand extends AbstractUGCCommand {

		@override dynamic execute([RockdotEvent event=null])
		 {
			super.execute(event);

			Map obj = {};
			obj["uid"] = _ugcModel.userDAO.uid;
			obj["locale"] = RockdotConstants.LANGUAGE + "_" + RockdotConstants.MARKET;

			amfOperation("GamingEndpoint.checkPermissionToPlayLocale", [obj]);
		}


		@override bool dispatchCompleteEvent([dynamic result=null])
		 {
			_ugcModel.gaming.allowedToPlay = result.result;
			return super.dispatchCompleteEvent(_ugcModel.gaming.allowedToPlay);
		}
	}

