part of rockdot_dart;

	 @retain
class ScreenDisappearCommand extends AbstractScreenCommand {
		 ScreenDisplaylistAppearDisappearVO _vo;

		@override dynamic execute([RockdotEvent event=null])
		 {
			super.execute(event);

			_vo = event.data;
			_vo.target.addEventListener(ManagedSpriteComponentEvent.DISAPPEAR_COMPLETE, dispatchCompleteEvent);
			_vo.target.disappear(_vo.duration);

			return null;
		}

		@override bool dispatchCompleteEvent([dynamic result=null])
		 {
			_vo.target.removeEventListener(ManagedSpriteComponentEvent.DISAPPEAR_COMPLETE, dispatchCompleteEvent);
			// _vo.target.alpha = 0;
			// _vo.target.visible = false;

			if (_vo.autoDestroy == true) {
				_vo.target.destroy();
			}

			return super.dispatchCompleteEvent(result);
		}
	}

