 part of stagexl_rockdot;







	 @retain
class FBEventCreateCommand extends AbstractFBCommand {

		@override
		  dynamic execute([RockdotEvent event=null]) {
			super.execute(event);

			IOperation operation = new FacebookOperation("/" + _fbModel.session.uid + "/events", {"name":"testxx", "start_time":"1298049557", "location":"testort", "page_id":"178442298858267", "privacy":"CLOSED"}, "POST");
			operation.addCompleteListener(dispatchCompleteEvent);
			operation.addErrorListener(_handleError);
		}
	}

