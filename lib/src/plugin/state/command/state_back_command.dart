part of stagexl_rockdot;

	/**
	 * @author Nils Doehring (nilsdoehring(gmail as at).com)
	 */
	 @retain
class StateBackCommand extends AbstractStateCommand {
		@override dynamic execute([RockdotEvent event=null])
		 {
			super.execute(event);

			if (_stateModel.historyCount != 0) {
				_stateModel.historyCount--;
				this.log.finer("Go back to: count {0}, url {1}, history: false", [_stateModel.historyCount, _stateModel.history[_stateModel.historyCount].url]);
			}
			new RockdotEvent(StateEvents.ADDRESS_SET, _stateModel.history[_stateModel.historyCount].url, dispatchCompleteEvent).dispatch();
		}

		
		@override bool dispatchCompleteEvent([dynamic result=null])
		 {
			return super.dispatchCompleteEvent(result);
		}


	}

