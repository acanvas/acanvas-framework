 part of rockdot_dart;

	/**
	 * @author Nils Doehring (nilsdoehring@gmail.com)
	 */
	 class RadioGroupEvent extends Event {
		 static final String BUTTON_SELECTED = "RadioGroupEvent.BUTTON_SELECTED";
		 int index;
	 RadioGroupEvent(String type,int index,[bool bubbles=false]) : super(type, bubbles) {
			this.index = index;
		}

		
		@override 
		  Event clone() {
			return new RadioGroupEvent(type, index, bubbles);
		}
	}
