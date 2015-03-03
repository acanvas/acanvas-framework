part of stagexl_rockdot.state;


class AbstractStateCommand extends CoreCommand implements IStateModelAware, IScreenModelAware{
		
		 ScreenModel _uiModel; 
		void set uiModel(ScreenModel uiModel) {
			_uiModel = uiModel;
		}

		 StateModel _stateModel; 
			StateModel get stateModel => _stateModel;
		void set stateModel(StateModel stateModel) {
			_stateModel = stateModel;
		}

	}

