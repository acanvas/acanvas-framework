part of rockdot_dart;




	 @retain
class UGCFriendsReadCommand extends AbstractUGCCommand implements IFBModelAware{
		 FBModel _modelFB;
		void set fbModel(FBModel model) {
			_modelFB = model;
		}

		@override dynamic execute([RockdotEvent event=null])
		 {
			super.execute(event);

			if(_modelFB.friendsWhoAreAppUsers == null) {
				dispatchCompleteEvent(new List());
				return null;
			}

			List arr = [];
			for ( String k in _modelFB.friendsWhoAreAppUsers ) {
				arr.add(_modelFB.friendsWhoAreAppUsers[ k ].id);
			}

			amfOperation("UGCEndpoint.getFriendsWithItems", arr);

			return null;
		} void _handleComplete(OperationEvent event)
		 {
			List arr = [];

			for (int i = 0;i < event.result.length;i++) {
				FBUserVO user = _modelFB.friendsWhoAreAppUsers[event.result[i]];
				arr.add(user);
			}

			_ugcModel.friendsWithUGCItems = arr;
			dispatchCompleteEvent(arr);
		}


	}

