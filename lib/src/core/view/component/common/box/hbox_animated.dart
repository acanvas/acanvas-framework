 part of rockdot_dart;


	/**
	 * @author Nils Doehring (nilsdoehring@gmail.com)
	 */
	 class HBoxAnimated extends HBox {
		 num _duration;
	 HBoxAnimated([int padding=10, bool pixelSnapping=true, bool inverted=false, num duration=0.3]): super(padding, pixelSnapping, inverted)  {
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
				num targetX;
				child = getChildAt(0);
				targetX = _inverted ? targetX = -child.width : 0;
				if (child.alpha == 0) {
          child.x = targetX;
          stage.juggler.tween(child, _duration).animate.alpha.to(1.0);
        } else {
          stage.juggler.tween(child, _duration).animate
          ..x.to(targetX)
          ..alpha.to(1.0);
        }


				for (int i = 1;i < n;i++) {
					child = getChildAt(i);
					prevChild = getChildAt(i - 1);
					if (_inverted) {
						if (_pixelSnapping) targetX = (targetX - child.width - _padding).round();
						else targetX = targetX + child.width - _padding;
					} else {
						if (_pixelSnapping) targetX = (targetX + prevChild.width + _padding).round();
						else targetX = targetX + prevChild.width + _padding;
					}
					if (child.alpha == 0) {
              child.x = targetX;
              stage.juggler.tween(child, _duration).animate.alpha.to(1.0);
            } else {
              stage.juggler.tween(child, _duration).animate
              ..x.to(targetX)
              ..alpha.to(1.0);
            }
				}
			}
		}
	}
