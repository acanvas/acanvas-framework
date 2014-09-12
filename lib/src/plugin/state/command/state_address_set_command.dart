part of rockdot_dart;


	/**
	 * @author Nils Doehring (nilsdoehring(gmail as at).com)
	 */
	 @retain
class StateAddressSetCommand extends AbstractStateCommand {
		@override dynamic execute([RockdotEvent event=null])
		 {
			super.execute(event);
			_stateModel.addressService.changeAddress(event.data, dispatchCompleteEvent);
		}
	}

