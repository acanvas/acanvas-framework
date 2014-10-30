part of stagexl_rockdot;

	 @retain
class UGCHasExtendedUserCommand extends AbstractUGCCommand{

		@override dynamic execute([RockdotEvent event=null])
		 {
			super.execute(event);			
			
			Map dto = {'uid': event.data ? event.data : _ugcModel.userDAO.uid};
			
			amfOperation("UGCEndpoint.hasUserExtended", dto);
		}
		
		@override bool dispatchCompleteEvent([dynamic result=null])
		 {
			if(result.result == true){
				_ugcModel.hasUserExtendedDAO = true;
			}
			return super.dispatchCompleteEvent( result.result );
		}

	}

