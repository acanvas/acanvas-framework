part of rockdot_dart;

	 @retain
class UGCHasExtendedUserCommand extends AbstractUGCCommand{

		@override dynamic execute([RockdotEvent event=null])
		 {
			super.execute(event);			
			//event.data == uid String
			amfOperation("UGCEndpoint.hasUserExtended", event.data ? event.data : _ugcModel.userDAO.uid);
		}
		
		@override bool dispatchCompleteEvent([dynamic result=null])
		 {
			if(result.result == true){
				_ugcModel.hasUserExtendedDAO = true;
			}
			return super.dispatchCompleteEvent( result.result );
		}

	}

