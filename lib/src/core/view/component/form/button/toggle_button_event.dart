 part of rockdot_dart;

	/**
	 * @author Nils Doehring (nilsdoehring@gmail.com)
	 */
	 class ToggleButtonEvent extends Event {
		 static final String TOGGLE = "ToggleButtonEvent.TOGGLE";
	 ToggleButtonEvent(String type,[bool bubbles=false]): super(type, bubbles)  {
		}


		  Event clone() {
			return new ToggleButtonEvent(type, bubbles);
		}
	}
