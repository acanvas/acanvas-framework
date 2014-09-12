 part of rockdot_dart;


	 @retain
class FBUserGetInfoPermissionsCommand extends AbstractFBCommand {

		@override 
		  dynamic execute([RockdotEvent event=null]) {
			super.execute(event);
//			dispatchMessage("loading.facebook.login");

			IOperation operation = _context.getObject(FacebookConstants.OPERATION_FB, ["/me/permissions"]);
			operation.addCompleteListener(_handleComplete);
			operation.addErrorListener(_handleError);
		}

		  void _handleComplete(OperationEvent event) {
//			hideMessage("notification.facebook.loading")
			_fbModel.userPermissions = event.result;
			dispatchCompleteEvent(event.result);
		}
	}

