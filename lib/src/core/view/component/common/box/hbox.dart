 part of rockdot_dart;



	/**
	 * @author Nils Doehring (nilsdoehring@gmail.com)
	 */
	 class HBox extends SpriteComponent {
		 num _padding = 0;
		 int _size = 0;
		 bool _pixelSnapping;
		 bool _inverted;
	 HBox([int padding=10, bool pixelSnapping=true, bool inverted=false]) {
			_padding = padding;
			_pixelSnapping = pixelSnapping;
			_inverted = inverted;
			_ignoreCallSetSize = false;
		}


		@override 
		  DisplayObject addChild(DisplayObject child) {
			super.addChild(child);
			update();
			return child;
		}


		@override 
		  DisplayObject removeChild(DisplayObject child) {
			super.removeChild(child);
			update();
			return child;
		}


		@override 
		  DisplayObject addChildAt(DisplayObject child,int index) {
			super.addChildAt(child, index);
			update();
			return child;
		}


		@override 
		  DisplayObject removeChildAt(int index) {
			DisplayObject c = getChildAt(index);
		  super.removeChildAt(index);
			update();
			return c;
		}


		  num get padding {
			return _padding;
		}


		  void set padding(num value) {
			if (value != _padding) {
				_padding = value;
				update();
			}
		}


		  void setFixedSize(int size) {
			if (size != _size) {
				_size = size;
				if (numChildren > 1) {
					_padding = _calcPadding();
					update();
				}
			}
		}


		  num _calcPadding() {
			int n = numChildren;
			num totalWidth = 0;
			for (int i = 0;i < n;i++) {
				if(getChildAt(i) is ISpriteComponent){
					totalWidth += (getChildAt(i) as ISpriteComponent ).widthAsSet;
				}
				else{
					totalWidth += getChildAt(i).width;
				}
			}

			return (_size - totalWidth) / (numChildren - 1);
		}
		
		
		  void update() {
			if (_size != 0)
				_padding = _calcPadding();

			if (numChildren > 0) {
				int n = numChildren;
				DisplayObject child;
				DisplayObject prevChild;
				child = getChildAt(0);
				child.x = _inverted ? -child.width : 0;
				for (int i = 1;i < n;i++) {
					child = getChildAt(i);
					prevChild = getChildAt(i - 1);
					if (_inverted) {
						if (_pixelSnapping) child.x = (prevChild.x - child.width - _padding).round();
						else child.x = prevChild.x - child.width - _padding;
					} else {
						if (_pixelSnapping) child.x = (prevChild.x + prevChild.width + _padding).round();
						else child.x = prevChild.x + prevChild.width + _padding;
					}
				}
			}
		}


		  bool get pixelSnapping {
			return _pixelSnapping;
		}


		  void set pixelSnapping(bool pixelSnapping) {
			if (pixelSnapping != _pixelSnapping) {
				_pixelSnapping = pixelSnapping;
				update();
			}
		}


		  bool get inverted {
			return _inverted;
		}


		  void set inverted(bool value) {
			if (value != _inverted) {
				_inverted = value;
				update();
			}
		}
	}
