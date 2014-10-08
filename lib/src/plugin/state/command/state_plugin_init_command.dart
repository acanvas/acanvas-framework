part of stagexl_rockdot;



	 @retain
class StatePluginInitCommand extends AbstractStateCommand {

		@override dynamic execute([RockdotEvent event=null])
		 {
			super.execute(event);
			
			
		/*	if(!_stateModel.tracker && getProperty("project.api.google.analytics.key")) {
				_stateModel.tracker = new GATracker(RockdotConstants.getStage(), getProperty("project.api.google.analytics.key"), "AS3", false);
			}*/
			
			Assert.notNull(_context, "the objectFactory argument must not be null");
			List<String> names = _context.cache.getCachedNamesForType(StateVO);
			if (names != null) {
				for (String name in names){
					StateVO stateVO = _context.getObject(name);
					_stateModel.addStateVO(stateVO);
				}
			} else {
			}

			_stateModel.addressService = new SWFAddressService();
			
			dispatchCompleteEvent();
			return null;
		}
	}

