part of rockdot_dart;
	/**
	 * @author nilsdoehring
	 */
	 class CommandVO {
		 ICommand command;
		 RockdotEvent event;
	 CommandVO(ICommand command,RockdotEvent event) {
			
			this.event = event;
			this.command = command;
		}
	}

