part of stagexl_rockdot;








	/**
	 * @author Nils Doehring (nilsdoehring(gmail as at).com)
	 */
	 @retain
class StateRequestCommand extends AbstractStateCommand {

		@override dynamic execute([RockdotEvent event=null])
		 {
			super.execute(event);
			List urlData = event.data.split("?");
			StateVO stateVO = _stateModel.getPageVO(urlData[0].toLowerCase());

			if (stateVO != null) {
				if (urlData.length > 1) {
				  Map params = new Map();
				  List list = (urlData[1] as String).split("&");
				  list.forEach((String s) {
				    List split = s.split("=");
				    if(split.length > 1){
				      params[split[0]] = split[1];
				    }
				  });

					if (stateVO.params != null) {
						if (params.toString() != stateVO.params.toString())
						  stateVO.params = params;
					} else {
						stateVO.params = params;
					}
				} else {
					stateVO.params = null;
				}

				new RockdotEvent(StateEvents.STATE_VO_SET, stateVO, dispatchCompleteEvent).dispatch();



			} else {
				// TODO: Define routine for unregistered urls.
				new RockdotEvent(StateEvents.ADDRESS_SET, "/", dispatchCompleteEvent).dispatch();
			}

		}
	}

