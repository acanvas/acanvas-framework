 part of rockdot_dart;

	/**
	 * @author Nils Doehring (nilsdoehring@gmail.com)
	 */
 
  class Cell extends Button {
		 int _id = 0;
		 int get id => _id;
		 void set id(int idd){
		   _id = idd;
		 }
		 Object _data;
		 bool _isSelected = false;
		 bool _isMultiselection = false;
	 Cell() : super(){
			
		}


		  Object get data {
			return _data;
		}


		  void set data(Object data) {
			_data = data;
		}

		  void select() {
			if (!_isSelected) {
				_isSelected = true;
				redraw();
				submitCallbackParams = [this];
				_onClick();
			}
		}


		  void deselect() {
			if (_isSelected) {
				_isSelected = false;
				redraw();
			}
		}


		  bool get isSelected {
			return _isSelected;
		}

		  bool get isMultiselection {
			return _isMultiselection;
		}

		  void set isMultiselection(bool isMultiselection) {
			_isMultiselection = isMultiselection;
		}
	}

