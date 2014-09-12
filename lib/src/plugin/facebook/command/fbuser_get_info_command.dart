 part of rockdot_dart;


	 @retain
class FBUserGetInfoCommand extends AbstractFBCommand {

		@override
		  dynamic execute([RockdotEvent event=null]) {
			super.execute(event);
//			dispatchMessage("loading.facebook.login");

			IOperation operation = _context.getObject(FacebookConstants.OPERATION_FB, ["fql.query", {query:"SELECT uid, name, pic_square, is_app_user, birthday_date, email, hometown_location, locale FROM user WHERE uid = me()"}]); //trick!
			operation.addCompleteListener(_handleComplete);
			operation.addErrorListener(_handleError);
		}

		  void _handleComplete(OperationEvent event) {
			FBUserVO user = new FBUserVO(event.result[0]);
			if (user == null) {
				error = ( "Error parsing user from " + event.result );
				dispatchErrorEvent();
				return;
			}
			_fbModel.user = user;
			if(event.result[0]["hometown_location"] is Map){
				_fbModel.user.hometown_location = event.result[0]["hometown_location"]["name"];
			}
			_fbModel.user.id = user.uid;
			dispatchCompleteEvent(_fbModel.user);
		}
	}

