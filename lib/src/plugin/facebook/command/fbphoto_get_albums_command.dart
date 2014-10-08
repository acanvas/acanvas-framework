 part of stagexl_rockdot;



	 @retain
class FBPhotoGetAlbumsCommand extends AbstractFBCommand {

		@override 
		  dynamic execute([RockdotEvent event=null]) {
			super.execute(event);
//			dispatchMessage("notification.facebook.loading");
			
			String uid = _fbModel.user.id;
			IOperation operation = _context.getObject(FacebookConstants.OPERATION_FB, ["/" + uid + "/albums"]);
			operation.addCompleteListener(_handleComplete);
			operation.addErrorListener(_handleError);
		}

		  void _handleComplete(OperationEvent event) {
//			hideMessage("notification.facebook.loading")
			_fbModel.userAlbums = event.result;
			dispatchCompleteEvent(event.result);
		}
	}

