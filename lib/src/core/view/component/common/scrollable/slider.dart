part of rockdot_dart;



/**
	 * @author Nils Doehring (nilsdoehring@gmail.com)
	 */
class Slider extends SpriteComponent {
  //
  String _orientation;
  num _min = 0;
  num _max = 0;
  num _size = 0;
  bool _continuous = false;
  Sprite _thumb;
  int _thumbSize = 0;
  Sprite _background;
  num _mouseOffset = 0;
  num _value = 0;
  // States
  bool _interaction = false;
  bool _changing = false;
  bool _ori = false;
  // Momentum
  bool _momentumEnabled = false;
  num _momentum = 0;
  num _momentumDelta = 0;
  num momentumFriction = 0.85;
  num momentumClearThreshold = 1;
  // Mouse Wheel
  bool _mouseWheelEnabled;
  num mouseWheelSensitivity;
  Slider(String orientation, num min, num max, num size, [bool continuous = false]) : super() {
    _orientation = orientation;
    _min = min;
    _max = max;
    _size = size;
    _continuous = continuous;
    _value = _min;

    mouseWheelSensitivity = (_max - min) * 0.01;
    mouseWheelEnabled = true;

    if (_orientation == Orientation.HORIZONTAL) {
      _ori = true;
      _widthAsSet = size;
    } else {
      _ori = false;
      _heightAsSet = size;
    }

    if (_background == null) _background = new Sprite();
    if (thumb == null) thumb = new Sprite();
    _thumbSize = _ori ? _thumb.width : _thumb.height;
    size = _size;
  }


  void interactionStart([bool preventMomentum = false, bool addMouseListeners = true]) {
    if (!_interaction) {
      _interaction = true;

      clearMomentum();

      if (addMouseListeners == true) {
        stage.addEventListener(MouseEvent.MOUSE_MOVE, _onStageMouseMove);
        stage.addEventListener(MouseEvent.MOUSE_UP, _onStageMouseUp);
      }

      if (_momentumEnabled && !preventMomentum) addEventListener(Event.ENTER_FRAME, _calcMomentum);

      dispatchEvent(new SliderEvent(SliderEvent.INTERACTION_START, _value));
      changeStart();
    }
  }


  void interactionEnd() {
    if (_interaction) {
      _interaction = false;
      stage.removeEventListener(MouseEvent.MOUSE_MOVE, _onStageMouseMove);
      stage.removeEventListener(MouseEvent.MOUSE_UP, _onStageMouseUp);

      dispatchEvent(new SliderEvent(SliderEvent.INTERACTION_END, _value));

      if (_momentumEnabled) {
        removeEventListener(Event.ENTER_FRAME, _calcMomentum);
        momentumStart();
      } else {
        changeEnd();
      }
    }
  }


  void momentumStart() {
    if (_momentum != 0) {
      dispatchEvent(new SliderEvent(SliderEvent.MOMENTUM_START, _value));
      addEventListener(Event.ENTER_FRAME, _applyMomentum);
    } else {
      changeEnd();
    }
  }


  void momentumEnd() {
    dispatchEvent(new SliderEvent(SliderEvent.MOMENTUM_END, _value));
    changeEnd();
  }


  void changeStart() {
    if (!_changing) {
      _changing = true;
      dispatchEvent(new SliderEvent(SliderEvent.CHANGE_START, _value));
    }
  }


  void changeEnd() {
    if (_changing) {
      _changing = false;
      dispatchEvent(new SliderEvent(SliderEvent.CHANGE_END, _value));
    }
  }


  void _onBackgroundMouseDown(MouseEvent event) {
    interactionStart(true);
    num pos = (_ori ? mouseX : mouseY) - _thumbSize * 0.5 - (_ori ? _background.x : _background.y);
    value = convertPositionToValue(pos);
    _mouseOffset = (_ori ? stage.mouseX : stage.mouseY) - pos;
  }


  void _onThumbMouseDown(MouseEvent event) {
    interactionStart();
    //offset not right
    print("_background.y: ${_background.y}, _thumbSize: $_thumbSize");
    _mouseOffset = (_ori ? stage.mouseX : stage.mouseY) - (_ori ? _thumb.x : _thumb.y);// - _thumbSize * 0.5;
  }


  void _onStageMouseMove(MouseEvent event) {
    num mousePos = (_ori ? stage.mouseX : stage.mouseY);// - _thumbSize * 0.5;
    value = convertPositionToValue(mousePos - _mouseOffset);
    // event.updateAfterEvent();
  }


  void _onStageMouseUp(MouseEvent event) {
    interactionEnd();
  }


  /**
		 * 
		 * COMMON
		 *  
		 */
  num convertPositionToValue(num position) {
    return _min + (_max - _min) * (position / (_size - _thumbSize));
  }


  void _updateThumbPosition() {
    num bgp = (_ori ? _background.x : _background.y);
    num top = (_value - _min);
    num btm = (_max - _min) * (_size - _thumbSize);
    int pos = (top / (btm == 0 ? 1 : btm) + bgp).round();
    _ori ? _thumb.x = pos : _thumb.y = pos;
  }


  num get value {
    return _value;
  }


  void set value(num newValue) {
    
    if (newValue < _min) newValue = minimum; else if (newValue > _max) newValue = _max;
    if (!_continuous) newValue = (newValue).round();

    if (newValue != _value) {
      _value = newValue;
      _updateThumbPosition();
      dispatchEvent(new SliderEvent(SliderEvent.VALUE_CHANGE, _value));
    }
  }



  @override
  void setSize(num w, num h) {
    size = _orientation == Orientation.HORIZONTAL ? w : h;
    super.setSize(w, h);
  }

  num get size {
    return _size;
  }


  void set size(num value) {
    _size = value;
    _updateThumbPosition();
  }


  num get minimum {
    return _min;
  }


  void set minimum(num minimum) {
    if (minimum != _min) {
      _min = minimum;
      _updateThumbPosition();
    }
  }


  num get maxValue {
    return _max;
  }


  void set maxValue(num max) {
    if (max != _max) {
      _max = max;
      _updateThumbPosition();
    }
  }


  bool get continuous {
    return _continuous;
  }


  void set continuous(bool continuous) {
    if (continuous != _continuous) {
      _continuous = continuous;
      _updateThumbPosition();
    }
  }


  @override
  void set enabled(bool value) {

    if (value == true) {
      _background.addEventListener(MouseEvent.MOUSE_DOWN, _onBackgroundMouseDown, useCapture: false, priority: 0);
      _thumb.addEventListener(MouseEvent.MOUSE_DOWN, _onThumbMouseDown, useCapture: false, priority: 0);
    } else {
      _background.removeEventListener(MouseEvent.MOUSE_DOWN, _onBackgroundMouseDown);
      _thumb.removeEventListener(MouseEvent.MOUSE_DOWN, _onThumbMouseDown);
    }

    super.enabled = mouseChildren = value;
  }


  Sprite get thumb {
    return _thumb;
  }


  void set thumb(Sprite thumb) {
    if (thumb != _thumb) {
      _thumb = thumb;
      _thumbSize = _ori ? _thumb.width : _thumb.height;
      _updateThumbPosition();
    }
  }


  /**
		 * 
		 * MOUSE WHEEL
		 *  
		 */
  bool get mouseWheelEnabled {
    return _mouseWheelEnabled;
  }


  void set mouseWheelEnabled(bool value) {
    if (value != _mouseWheelEnabled) {
      _mouseWheelEnabled = value;
      if (_mouseWheelEnabled) addEventListener(MouseEvent.MOUSE_WHEEL, _onMouseWheel, useCapture: false, priority: 0); 
      else removeEventListener(MouseEvent.MOUSE_WHEEL, _onMouseWheel);
    }
  }


  void _onMouseWheel(MouseEvent event) {
    if (event.deltaY < 0){
      if(_value >= _max) return;
    }
    if (event.deltaY > 0){
      if(_value == _min) return;
    }
    
    interactionStart();
    
    value = value - event.deltaY * mouseWheelSensitivity;
    interactionEnd();
  }


  /**
		 * 
		 * MOMENTUM
		 *  
		 */
  bool get momentumEnabled {
    return _momentumEnabled;
  }


  void set momentumEnabled(bool value) {
    _momentumEnabled = value;
  }


  void clearMomentum() {
    if (_momentumEnabled) {
      removeEventListener(Event.ENTER_FRAME, _calcMomentum);
      removeEventListener(Event.ENTER_FRAME, _applyMomentum);
      _momentum = _momentumDelta = 0;
    }
  }


  void _calcMomentum(Event event) {
    _momentum = _value - _momentumDelta;
    _momentumDelta = _value;
  }


  void _applyMomentum(Event event) {
    _momentum *= momentumFriction;
    if ((_momentum).abs() < momentumClearThreshold) {
      value += _momentum;
      clearMomentum();
      momentumEnd();
    } else {
      value += _momentum;
      if (_value <= _min) {
        clearMomentum();
        value = _min;
        momentumEnd();
      } else if (_value >= _max) {
        clearMomentum();
        value = _max;
        momentumEnd();
      }
    }
  }


  bool get interaction {
    return _interaction;
  }


  bool get changing {
    return _changing;
  }
}
