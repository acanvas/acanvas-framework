part of rockdot_dart;


	/**
	 * @author Nils Doehring (nilsdoehring(gmail as at).com)
	 */
	 @retain
class StateSetParamsCommand extends AbstractStateCommand {

		@override dynamic execute([RockdotEvent event=null])
		 {
			super.execute(event);
			StateVO vo = event.data;
			_stateModel.addressService.onAddressChanged(vo);
			if(_stateModel.currentPage != null){
				_stateModel.currentPage.setData( vo.params );
			}
			
			dispatchCompleteEvent();
		}
	}

