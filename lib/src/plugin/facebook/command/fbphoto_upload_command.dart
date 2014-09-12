 part of rockdot_dart;






	 @retain
class FBPhotoUploadCommand extends AbstractFBCommand {

		@override
		  dynamic execute([RockdotEvent event=null]) {
			super.execute(event);

			VOFBPhotoUpload vo = event.data;

			IOperation operation = _context.getObject(FacebookConstants.OPERATION_FB, [vo.location, {"image":vo.bmp, "message":vo.caption, "fileName":vo.fileName}, "POST"]);
			operation.addCompleteListener(dispatchCompleteEvent);
			operation.addErrorListener(_handleError);
		}
	}

