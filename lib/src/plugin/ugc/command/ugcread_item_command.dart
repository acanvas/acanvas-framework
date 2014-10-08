part of stagexl_rockdot;

	 @retain
class UGCReadItemCommand extends AbstractUGCCommand {

		@override dynamic execute([RockdotEvent event=null])
		 {
			super.execute(event);			
			//event.data == id INT
			amfOperation("UGCEndpoint.readItem", event.data);
		}
		
		@override bool dispatchCompleteEvent([dynamic result=null])
		 {
			UGCItemVO ret;
			if(result.result.length > 0){
				ret = new UGCItemVO(result.result[0]);
				_ugcModel.currentItemDAO = ret;
			}
			return super.dispatchCompleteEvent( ret );
		}
	}

