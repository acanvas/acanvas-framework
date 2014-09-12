part of rockdot_dart;




	/**
	 * @flowerModelElementId _0bg6sC9LEeG0Qay4mHgS6g
	 */
	 class StatePlugin extends AbstractOrderedFactoryPostProcessor {
	 StatePlugin():super(10) {
		}


		@override IOperation postProcessObjectFactory(IObjectFactory objectFactory)
		{
			
			/* Objects */
			RockdotContextHelper.registerClass(objectFactory, StateConstants.CTX_MODEL_STATE, StateModel, true);

			/* Object Postprocessors */
			objectFactory.addObjectPostProcessor(new StateModelInjector(objectFactory));
			
			/* Commands */
			Map commandMap = new Map();
			commandMap[ StateEvents.INIT ] = StatePluginInitCommand; 
			
			// 1. dispatched by button, sent to proxy
			commandMap[StateEvents.ADDRESS_SET] = StateAddressSetCommand;

			// 2. select page vo by url, received from proxy
			commandMap[StateEvents.STATE_REQUEST] = StateRequestCommand;
			
			// 3. set page vo
			commandMap[StateEvents.STATE_VO_SET] = StateSetCommand;
			commandMap[StateEvents.STATE_VO_FORWARD] = StateForwardCommand;
			commandMap[StateEvents.STATE_VO_BACK] = StateBackCommand;

			// 4b. if it's the same state, only change params 
			commandMap[StateEvents.STATE_PARAMS_CHANGE] = StateSetParamsCommand;
			
			RockdotContextHelper.registerCommands(objectFactory, commandMap);

			
			/* Bootstrap Command */
			RockdotConstants.getBootstrap().add( StateEvents.INIT );
			
			
			return null;
		}
		


	}

