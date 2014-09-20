 part of rockdot_dart;



	/**
	 * @author Nils Doehring (nilsdoehring@gmail.com)
	 */
	 class VBox extends HBox {
	 VBox([int padding=10, bool pixelSnapping=true, bool inverted=false]) {
			_padding = padding;
			_pixelSnapping = pixelSnapping;
			_inverted = inverted;
			_ignoreCallSetSize = false;
		}

		@override 
		  void setSize(int w,int h) {
			DisplayObject child;
			for (int i = 0; i < numChildren; i++) {
				child = getChildAt(i);
				if (child is TextField) (child as TextField).width = w;
			}
			_heightAsSet = h;
			super.setSize(w, 0);//sets only width of children
		}
		
		
		@override 
		  void setFixedSize(int size) {
			if (size != _size) {
				_size = size;
				if (numChildren > 1) {
					_padding = _calcPadding();
					update();
				}
			}
		}


		@override 
		  num _calcPadding() {
			int n = numChildren;
			num totalHeight = 0;
			for (int i = 0;i < n;i++) {
				if(getChildAt(i) is ISpriteComponent){
					totalHeight += (getChildAt(i) as ISpriteComponent ).heightAsSet;
				}
				else{
					totalHeight += getChildAt(i).height;
				}
			}

			return (_size - totalHeight) / (numChildren - 1);
		}


		@override 
		  void update() {
			if (_size != 0)
				_padding = _calcPadding();

			if (numChildren > 0) {
				int n = numChildren;
				DisplayObject child;
				DisplayObject prevChild;
				child = getChildAt(0);
				num h = /*child is ISpriteComponent ? (child as ISpriteComponent).heightAsSet :*/ child.height;
				child.y = _inverted ? - h : 0;
				for (int i = 1;i < n;i++) {
					child = getChildAt(i);
					prevChild = getChildAt(i - 1);
					if (_inverted) {
						h = /*child is ISpriteComponent ? (child as ISpriteComponent).heightAsSet :*/ child.height;
						if (_pixelSnapping) child.y = (prevChild.y - h - _padding).round();
						else child.y = prevChild.y + h - _padding;
					} else {
						h = /*prevChild is ISpriteComponent ? (prevChild as ISpriteComponent).heightAsSet :*/ prevChild.height;
						if (_pixelSnapping) child.y = (prevChild.y + h + _padding).round();
						else child.y = prevChild.y + h + _padding;
					}
				}
			}
		}
	}
