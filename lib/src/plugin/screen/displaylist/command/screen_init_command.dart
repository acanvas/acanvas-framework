part of stagexl_rockdot;




	 @retain
class ScreenInitCommand extends AbstractScreenCommand {

		@override dynamic execute([RockdotEvent event=null])
		 {
			super.execute(event);
			
			IManagedSpriteComponent ui;
			if(event.data != null){
				ui = (event.data as IManagedSpriteComponent);
			}
			else if(_stateModel.currentPage != null){
				//TODO failsafe minimal width/height
				ui = _stateModel.currentPage;
			}
			
			if(ui.getInitialized()){
				dispatchCompleteEvent();										
			}
			else{
				ui.addEventListener(ManagedSpriteComponentEvent.INIT_COMPLETE, dispatchCompleteEvent);
				ui.init(_stateModel.currentPageVOParams);
			}
			
			return null;
		}
	}

