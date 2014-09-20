 part of rockdot_dart;

	/**
	 * @author Nils Doehring (nilsdoehring@gmail.com)
	 */
	 class RadioGroupH extends HBox {
		 String _orientation;
		 int _selectedButtonIndex = 0;
	 RadioGroupH([int padding=0]): super(padding)  {
			addEventListener(ToggleButtonEvent.TOGGLE, _onBtnToggle, useCapture: true);
		}


		  void selectButton(int index) {
			(getChildAt(_selectedButtonIndex) as RadioButton).isToggled = false;
			(getChildAt(index) as RadioButton).isToggled = true;
			_selectedButtonIndex = index;
			dispatchEvent(new RadioGroupEvent(RadioGroupEvent.BUTTON_SELECTED, index));
		}


		  void _onBtnToggle(ToggleButtonEvent event) {
			RadioButton btn = event.target as RadioButton;
			if (!btn.isToggled) selectButton(getChildIndex(btn));
		}


		  int get selectedButtonIndex {
			return _selectedButtonIndex;
		}


		@override 
		  void destroy() {
			removeEventListener(ToggleButtonEvent.TOGGLE, _onBtnToggle);
			super.destroy();
		}

	}
