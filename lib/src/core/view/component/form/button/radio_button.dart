 part of rockdot_dart;

	/**
	 * @author Nils Doehring (nilsdoehring@gmail.com)
	 */
	 class RadioButton extends ToggleButton {
	 RadioButton(): super()  {
		}

		@override 
		void onClick([MouseEvent event = null]) {
			dispatchEvent(new ToggleButtonEvent(ToggleButtonEvent.TOGGLE));
		}

		@override 
		  void set isToggled(bool value) {
			_isToggled = value;
		}
	}
