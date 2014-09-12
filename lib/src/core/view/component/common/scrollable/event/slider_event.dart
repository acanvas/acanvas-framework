 part of rockdot_dart;

	/**
	 * @author Nils Doehring (nilsdoehring@gmail.com)
	 */
	 class SliderEvent extends Event {
		 static const String VALUE_CHANGE = "SliderEvent.VALUE_CHANGE";
		 static const String CHANGE_START = "SliderEvent.CHANGE_START";
		 static const String CHANGE_END = "SliderEvent.CHANGE_END";
		//
		 static const String INTERACTION_START = "SliderEvent.INTERACTION_START";
		 static const String INTERACTION_END = "SliderEvent.INTERACTION_END";
		 static const String MOMENTUM_START = "SliderEvent.MOMENTUM_START";
		 static const String MOMENTUM_END = "SliderEvent.MOMENTUM_END";
		 num value;
	 SliderEvent(String type,num value,[bool bubbles=false, bool cancelable=false]): super(type, bubbles) {
			this.value = value;
			;
		}


		  Event clone() {
			return new SliderEvent(type, value, bubbles);
		}
	}

