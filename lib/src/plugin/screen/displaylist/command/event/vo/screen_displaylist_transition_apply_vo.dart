part of rockdot_dart;

	/**
	 * @author nilsdoehring
	 */
	 class ScreenDisplaylistTransitionApplyVO  extends RockdotVO{
		 IEffect effect;
		 String transitionType;
		 ISpriteComponent targetPrimary;
		 ISpriteComponent targetSecondary;
		 num duration;
	 ScreenDisplaylistTransitionApplyVO(IEffect effect,String transitionType,ISpriteComponent targetPrimary,num duration,[ISpriteComponent targetSecondary=null]) {
			this.duration = duration;
			this.targetPrimary = targetPrimary;
			this.targetSecondary = targetSecondary;
			this.transitionType = transitionType;
			this.effect = effect;
		}
	}

