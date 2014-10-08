part of stagexl_rockdot;


	 @retain
class ScreenApplyEffectOutCommand extends AbstractScreenCommand {

		@override dynamic execute([RockdotEvent event=null])
		 {
			super.execute(event);

			ScreenDisplaylistEffectApplyVO vo = event.data;
			vo.effect.runOutEffect(vo.target, vo.duration, dispatchCompleteEvent);
			
			return null;
		}

		@override bool dispatchCompleteEvent([dynamic result=null])
		 {
			return super.dispatchCompleteEvent(result);
		}
	}

