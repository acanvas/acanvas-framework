part of stagexl_rockdot;






	 @retain
class GamingGetHighscoreCommand extends AbstractUGCCommand implements IFBModelAware{
		 FBModel _modelFB;
		void set fbModel(FBModel model) {
			_modelFB = model;
		}

		@override dynamic execute([RockdotEvent event=null])
		 {
			super.execute(event);
			amfOperation("GamingEndpoint.getHighscore", [{'uid':_ugcModel.userDAO.uid, 'friends':_modelFB.friendsWhoAreAppUsersIndexed}]);
		}


		@override bool dispatchCompleteEvent([dynamic result=null])
		 {
			_ugcModel.gaming.highscoreFriends = result.result.topFiveFriends;
			_ugcModel.gaming.highscoreAll = result.result.topTen;
			_ugcModel.gaming.rank = result.result.rank;
			return super.dispatchCompleteEvent(result.result);
		}
	}

