 part of rockdot_dart;







	 @retain
class FBFriendsGetInfoCommand extends AbstractFBCommand {

		@override
		  dynamic execute([RockdotEvent event=null]) {
			super.execute(event);
//			new BaseEvent(StateEvents.STATE_SET, "loading_facebook_friends").dispatch();


			Map friends = _fbModel.friends;
			List arr = [];

			for ( String k in friends ) {
				arr.add(friends[ k ].id);
			}

			IOperation operation = _context.getObject(FacebookConstants.OPERATION_FB, ["fql.query", {'query':"SELECT uid, name, pic_square, is_app_user FROM user WHERE uid = me() OR uid IN (" + arr.join(",") + ")"}]); //trick!
			operation.addCompleteListener(_handleComplete);
			operation.addErrorListener(_handleError);
		}

		  void _handleComplete(OperationEvent event) {
			_fbModel.friendsWithAdditionalInfo = event.result;
			dispatchCompleteEvent(event.result);
		}
	}

