part of rockdot_dart;

	/**
	 * @author nilsdoehring
	 */
	 class ScreenDisplaylistEffectApplyVO extends RockdotVO{
		 IEffect effect;
		 ISpriteComponent target;
		 num duration;
	 ScreenDisplaylistEffectApplyVO(IEffect effect,ISpriteComponent target,num duration) {
			this.effect = effect;
			this.target = target;
			this.duration = duration;
		}
	}

