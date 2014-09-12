 part of rockdot_dart;

	/**
	 * @author Nils Doehring (nilsdoehring@gmail.com)
	 */
	 class ScrollViewEvent extends Event {
		 static const String CHANGE_START = "ScrollViewEvent.CHANGE_START";
		 static const String CHANGE_END = "ScrollViewEvent.CHANGE_END";
		 static const String INTERACTION_START = "ScrollViewEvent.INTERACTION_START";
		 static const String INTERACTION_END = "ScrollViewEvent.INTERACTION_END";
	 
		 ScrollViewEvent(String type,[bool bubbles=false, bool cancelable=false]):super(type, bubbles) {
		}


		  Event clone() {
			return new ScrollViewEvent(type, bubbles);
		}
	}

