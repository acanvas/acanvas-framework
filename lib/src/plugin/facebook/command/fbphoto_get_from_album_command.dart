 part of stagexl_rockdot;







	 @retain
class FBPhotoGetFromAlbumCommand extends AbstractFBCommand {

		@override 
		  dynamic execute([RockdotEvent event=null]) {
			super.execute(event);
//			dispatchMessage("notification.facebook.loading");
			
			IOperation operation = _context.getObject(FacebookConstants.OPERATION_FB, ["/" + event.data + "/photos"]);
			operation.addCompleteListener(_handleComplete);
			operation.addErrorListener(_handleError);
		}

		

		  void _handleComplete(OperationEvent event) {
			_fbModel.userAlbumPhotos = event.result;
			_fbModel.userAlbumPhotos[0].totalrows = _fbModel.userAlbumPhotos.length;
			
//			hideMessage("notification.facebook.loading");
			
			dispatchCompleteEvent(_fbModel.userAlbumPhotos);
		}

		
	}

