part of stagexl_rockdot;

	 @retain
class ScreenAppearCommand extends AbstractScreenCommand {
		 ScreenDisplaylistAppearDisappearVO _vo;

		@override dynamic execute([RockdotEvent event=null])
		 {
			super.execute(event);

			_vo = event.data;
			_vo.target.addEventListener(ManagedSpriteComponentEvent.APPEAR_COMPLETE, dispatchCompleteEvent);
			_vo.target.appear(_vo.duration);

			return null;
		}

		@override bool dispatchCompleteEvent([dynamic result=null])
		 {
			_vo.target.removeEventListener(ManagedSpriteComponentEvent.APPEAR_COMPLETE, dispatchCompleteEvent);
			// _vo.target.alpha = 1;
			// _vo.target.visible = true;

			if (_vo.autoDestroy == true) {
				_vo.target.destroy();
			}

			return super.dispatchCompleteEvent(result);
		}
	}

