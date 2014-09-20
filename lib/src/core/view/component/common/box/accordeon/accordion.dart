 part of rockdot_dart;


	/**
	 * @author Nils Doehring (nilsdoehring@gmail.com)
	 */
	 class Accordion extends VBox {
		 num _duration = 0;
		 bool _multiselection = false;
		 Timer _timer;
	 Accordion([num duration=0.3, int padding=0]):super(padding, false, false) {
			_duration = duration;
		}


		  void _onCellSelected(Cell cell) {
			AccordionCell selectedItem = cell as AccordionCell;
			if (_multiselection) {
				_startAnimation(_duration);
			} else {
				deselectAll(selectedItem);
			}
		}


		  void _onCellDeselected(Cell cell) {
			_startAnimation(_duration);
		}


		  void deselectAll([AccordionCell exception=null]) {
			int n = numChildren;
			AccordionCell item;
			for (int i = 0; i < n; i++) {
				item = getChildAt(i) as AccordionCell;
				if (item != exception) item.deselect();
			}
			_startAnimation(_duration);
		}


		  void _startAnimation(num duration) {
			if(_timer != null){
			  _timer.cancel();
			}
			addEventListener(Event.ENTER_FRAME, _onEnterFrame);
			_timer = new Timer(new Duration(milliseconds: ((duration + 0.1)*1000).round()), () => removeEventListener(Event.ENTER_FRAME, _onEnterFrame));
		}


		  void _onEnterFrame(Event event) {
			update();
		}


		@override 
		  DisplayObject addChild(DisplayObject child) {
			if(child is Button){
				(child as Button).submitCallback = _onCellSelected;
			}
//			child.addEventListener(CellEvent.SELECTED, _onCellSelected, false, 0, true);
//			child.addEventListener(CellEvent.DESELECTED, _onCellDeselected, false, 0, true);
			(child as AccordionCell).duration = _duration;
			return super.addChild(child);
		}


		  num get duration {
			return _duration;
		}


		  void set duration(num value) {
			_duration = value;
			for (int i = 0; i < numChildren; i++) {
				(getChildAt(i) as AccordionCell).duration = _duration;
			}
		}
	}
