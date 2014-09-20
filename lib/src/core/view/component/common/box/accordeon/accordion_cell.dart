 part of rockdot_dart;
	/**
	 * @author Nils Doehring (nilsdoehring@gmail.com)
	 */
	 class AccordionCell extends Cell {
		// Duration of the expand / collapse animation
		 num _duration = 0;
	 AccordionCell(): super()  {
		}


		  num get duration {
			return _duration;
		}


		  void set duration(num value) {
			_duration = value;
		}
	}
