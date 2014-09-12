part of rockdot_dart;


	 @retain
class ScreenApplyEffectInCommand extends AbstractScreenCommand {

		@override dynamic execute([RockdotEvent event=null])
		 {
			super.execute(event);

			ScreenDisplaylistEffectApplyVO vo = event.data;
			vo.effect.runInEffect(vo.target, vo.duration, dispatchCompleteEvent);
			return null;
		}
		
		@override bool dispatchCompleteEvent([dynamic result=null])
		 {
			return super.dispatchCompleteEvent(result);
		}
		
	}

