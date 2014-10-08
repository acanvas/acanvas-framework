part of stagexl_rockdot;




	/**
	 * @flowerModelElementId _0kyygC9LEeG0Qay4mHgS6g
	 */
	 class ScreenDisplaylistPlugin extends ScreenPluginBase {

		@override IOperation postProcessObjectFactory(IObjectFactory objectFactory)
		{
			super.postProcessObjectFactory(objectFactory);
			
			/* Objects */
			_registerService(objectFactory);

			
			/* Commands */
			Map commandMap = new Map();
			commandMap[ ScreenDisplaylistEvents.SCREEN_INIT ] = ScreenInitCommand; 
			commandMap[ ScreenDisplaylistEvents.TRANSITION_PREPARE ] = ScreenTransitionPrepareCommand; 
			commandMap[ ScreenDisplaylistEvents.APPEAR ] = ScreenAppearCommand; 
			commandMap[ ScreenDisplaylistEvents.DISAPPEAR ] = ScreenDisappearCommand; 
			commandMap[ ScreenDisplaylistEvents.TRANSITION_RUN ] = ScreenTransitionRunCommand; 
			commandMap[ ScreenDisplaylistEvents.APPLY_EFFECT_IN ] = ScreenApplyEffectInCommand; 
			commandMap[ ScreenDisplaylistEvents.APPLY_EFFECT_OUT ] = ScreenApplyEffectOutCommand; 
			
			commandMap[ StateEvents.STATE_CHANGE ] = ScreenSetCommand;
			
			RockdotContextHelper.registerCommands(objectFactory, commandMap);
			
			return null;
		} void _registerService(IObjectFactory objectFactory)
		 {
			RockdotContextHelper.registerClass(objectFactory, ScreenPluginBase.SERVICE_UI, ScreenDisplaylistService, true);
		}
	}

