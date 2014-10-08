part of stagexl_rockdot;

	/**
	 * @author nilsdoehring
	 */
	 class ScreenDisplaylistTransitionPrepareVO extends RockdotVO {
		 ISpriteComponent outTarget;
		 ISpriteComponent inTarget;
		 IEffect effect;
		 bool modal;
		 String transitionType;
		 num initialAlpha = 0;
	 
		 ScreenDisplaylistTransitionPrepareVO(String transitionType,ISpriteComponent outTarget,IEffect effect,ISpriteComponent inTarget,bool modal,num initialAlpha) {
			this.transitionType = transitionType;
			this.modal = modal;
			this.outTarget = outTarget;
			this.inTarget = inTarget;
			this.effect = effect;
			this.initialAlpha = initialAlpha;
		}
	}

