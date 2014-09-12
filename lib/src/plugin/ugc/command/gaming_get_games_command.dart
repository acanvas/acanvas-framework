part of rockdot_dart;






	 @retain
class GamingGetGamesCommand extends AbstractUGCCommand {

		@override dynamic execute([RockdotEvent event=null])
		 {
			super.execute(event);
			amfOperation("GamingEndpoint.getGames", [_ugcModel.userDAO.uid]);
		}


		@override bool dispatchCompleteEvent([dynamic result=null])
		 {
			_ugcModel.gaming.games = result.result.games;
			return super.dispatchCompleteEvent(result.result);
		}
	}

