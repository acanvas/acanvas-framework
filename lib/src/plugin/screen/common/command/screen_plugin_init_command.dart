part of stagexl_rockdot;

	 @retain
class ScreenPluginInitCommand extends AbstractScreenCommand {

		@override dynamic execute([XLSignal event=null])
		 {
			super.execute(event);
			
			IScreenService _uiService = _context.getObject(ScreenPluginBase.SERVICE_UI);
			_uiService.init(dispatchCompleteEvent);
			return;
			
		}
	}

