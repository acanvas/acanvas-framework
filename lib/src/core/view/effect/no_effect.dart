part of rockdot_dart;

	 class NoEffect extends BasicEffect {
	 NoEffect():super() {
			
			_applyRecursively = false;
		}
		
		@override void runInEffect(ISpriteComponent target,double duration,Function callback)
		 {
			target.alpha = 1;
			callback.call();
		}
		@override void runOutEffect(ISpriteComponent target,double duration,Function callback)
		 {
			callback.call();
		}

	}

