part of stagexl_rockdot;

	/**
	 * @author nilsdoehring
	 */
	 class ScreenDisplaylistAppearDisappearVO  extends RockdotVO{
		 ISpriteComponent target;
		 num duration;
		 bool autoDestroy;
	 ScreenDisplaylistAppearDisappearVO(ISpriteComponent target,num duration,[bool autoDestroy=false]) {
			this.autoDestroy = autoDestroy;
			this.duration = duration;
			this.target = target;
		}
	}

