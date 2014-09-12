part of rockdot_dart;



	 class ComponentWithDataProxy extends RockdotSpriteComponent {
		
		 DataProxy _proxy; 
		void set listproxy(DataProxy m) {
			_proxy = m;
		} 
		DataProxy get listproxy {
			return _proxy;
		}
		
		 dynamic _data; 
		dynamic get data {
			return _data;
		} 
		void set data(dynamic data) {
			_data = data;
		}
	 ComponentWithDataProxy():super() {
			
		}


		
	}

