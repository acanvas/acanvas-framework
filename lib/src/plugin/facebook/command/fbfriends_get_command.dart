 part of stagexl_rockdot;







	 @retain
class FBFriendsGetCommand extends AbstractFBCommand {

		@override 
		  dynamic execute([RockdotEvent event=null]) {
			super.execute(event);
//			new BaseEvent(StateEvents.STATE_SET, "loading_facebook_friends").dispatch();
			
			IOperation operation = _context.getObject(FacebookConstants.OPERATION_FB, ["/" + _fbModel.user.uid + "/friends"]);
			operation.addCompleteListener(_handleComplete);
			operation.addErrorListener(dispatchErrorEvent);
		}

		
		
		  void _handleComplete(OperationEvent event) {
//			new BaseEvent(StateEvents.STATE_SET, "loading_facebook_friends").dispatch();
			_fbModel.friends = event.result;
			dispatchCompleteEvent(event.result);
		}
	}

