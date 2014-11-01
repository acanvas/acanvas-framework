part of stagexl_rockdot;
	/**
	 * @author nilsdoehring
	 */
	 class CommandVO {
		 ICommand command;
		 XLSignal event;
	 CommandVO(ICommand command,XLSignal event) {
			
			this.event = event;
			this.command = command;
		}
	}

