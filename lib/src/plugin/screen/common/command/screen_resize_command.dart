part of stagexl_rockdot.screen;


	 //@retain
class ScreenResizeCommand extends AbstractScreenCommand {

		@override dynamic execute([XLSignal event=null])
		 {
			super.execute(event);
			
			if(event.data != null){
				if(event.data is ISpriteComponent){
					(event.data as ISpriteComponent).setSize(_uiService.stage.stageWidth, _uiService.stage.stageHeight);
				}
				else{
					event.data.setSize(_uiService.stage.stageWidth, _uiService.stage.stageHeight);
				}
			}
			else {
			  ///only execute if not already resized via [AbstractScreenService]
			  if(_stateModel.currentPage != null && !_stateModel.currentPage.ignoreCallSetSize){
				  //TODO failsafe minimal width/height
				  _stateModel.currentPage.setSize(_uiService.stage.stageWidth, _uiService.stage.stageHeight);
			  }
			}
						
			dispatchCompleteEvent();
			
			return null;
		}
	}

