 part of rockdot_dart;


	/**
	 * @author Nils Doehring (nilsdoehring@gmail.com)
	 */
	 class VBoxAnimated extends VBox {
		 num _duration;
	 VBoxAnimated([int padding=10, bool pixelSnapping=true, bool inverted=false, num duration=0.3]): super(padding, pixelSnapping, inverted)  {
			_duration = duration;
		}


		@override 
		  DisplayObject addChild(DisplayObject child) {
			child.alpha = 0;
			return super.addChild(child);
		}


		@override 
		  DisplayObject addChildAt(DisplayObject child,int index) {
			child.alpha = 0;
			return super.addChildAt(child, index);
		}


		@override 
		  void update() {
			if (_size != 0)
				_padding = _calcPadding();

			if (numChildren > 0) {
				int n = numChildren;
				DisplayObject child;
				DisplayObject prevChild;
				num targetY;
				child = getChildAt(0);
				targetY = _inverted ? targetY = -child.height : 0;
				if (child.alpha == 0) {
					child.y = targetY;
					stage.juggler.tween(child, _duration).animate.alpha.to(1.0);
				} else {
					stage.juggler.tween(child, _duration).animate
					..y.to(targetY)
					..alpha.to(1.0);
				}

				for (int i = 1;i < n;i++) {
					child = getChildAt(i);
					prevChild = getChildAt(i - 1);
					if (_inverted) {
						if (_pixelSnapping) targetY = (targetY - child.height - _padding).round();
						else targetY = targetY + child.height - _padding;
					} else {
						if (_pixelSnapping) targetY = (targetY + prevChild.height + _padding).round();
						else targetY = targetY + prevChild.height + _padding;
					}
					if (child.alpha == 0) {
						child.y = targetY;
						stage.juggler.tween(child, _duration).animate.alpha.to(1.0);
					} else {
						stage.juggler.tween(child, _duration).animate
    				..y.to(targetY)
    				..alpha.to(1.0);
					}
				}
			}
		}
	}
