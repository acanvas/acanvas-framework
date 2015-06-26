part of stagexl_rockdot.state;


	/**
	 * @author Nils Doehring (nilsdoehring(gmail as at).com)
	 */
	 //@retain
class StateSetParamsCommand extends AbstractStateCommand {

		@override dynamic execute([XLSignal event=null])
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

