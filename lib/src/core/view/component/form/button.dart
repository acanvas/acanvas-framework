part of rockdot_dart;



	 class Button extends SpriteComponent {
		 String _label; 
		 
		 Button():super(){
			
			buttonMode = true;
			useHandCursor = true;
			mouseChildren = false;
			enabled = true;
			ignoreSetEnabled = true;
		}
		
		
		@override 
		void set enabled(bool value) {
			if(_enabled == value){
			  return;
			}
		  
		  super.enabled = value;
			mouseChildren = false;
			
			if(value == true){
				addEventListener(MouseEvent.MOUSE_UP, _onClick);
				addEventListener(MouseEvent.ROLL_OVER, onRollOver);
				addEventListener(MouseEvent.ROLL_OUT, onRollOut);
				onRollOut();
			}
			else{
				removeEventListener(MouseEvent.MOUSE_UP, _onClick);
				removeEventListener(MouseEvent.ROLL_OVER, onRollOver);
				removeEventListener(MouseEvent.ROLL_OUT, onRollOut);
				onRollOver();
			}
		} void setLabel(String label)
		{
			_label = label;
		} void _onClick([MouseEvent event=null])
		 {
			if(_submitCallback != null){
				Function.apply(_submitCallback, _submitCallbackParams);
			}
			if(_submitEvent != null){
				_submitEvent.dispatch();
			}
		} void onRollOver([MouseEvent event=null])
		 {
			// Override this method
		} void onRollOut([MouseEvent event=null])
		 {
			// Override this method
		}
	}

