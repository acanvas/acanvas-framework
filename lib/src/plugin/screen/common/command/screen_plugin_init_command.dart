part of stagexl_rockdot.screen;

	 //@retain
class ScreenPluginInitCommand extends AbstractScreenCommand {

		@override dynamic execute([XLSignal event=null])
		 {
			super.execute(event);
			
			IScreenService _uiService = applicationContext.getObject(ScreenPluginBase.SERVICE_UI);
			_uiService.init(dispatchCompleteEvent);
			return;
			
		}
	}

