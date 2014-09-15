part of rockdot_dart;


/**
	 * @author Nils Doehring (nilsdoehring@gmail.com)
	 */
class Scrollbar extends Slider {
  static int firstPageScrollIntervall = 300;
  static int pageScrollIntervall = 50;
  num _pageScrollDuration = 0;
  num _pageScrollDistance = 0;
  bool _isTweening = false;
  NumericStepper _pageStepper;
  num _pages = 0;
  bool _snapToPage = false;
  bool _bounce = false;
  Timer _timer;

  Scrollbar(String orientation, num max, num size, [num pageScrollDuration = 0.7]) : super(orientation, 0, max, size, false) {
    _pageScrollDuration = pageScrollDuration;
  }

  void prepare() {
    _pageStepper = new NumericStepper(0, 0, 1, false);

    //_runTimer(firstPageScrollIntervall);

    mouseWheelEnabled = false;
    if (pages == 0) pages = 1;
  }


  @override
  void interactionStart([bool preventMomentum = false, bool addMouseListeners = true]) {
    if (!_interaction) {
      killPageTween();
      super.interactionStart(preventMomentum, addMouseListeners);
    }
  }


  @override
  void interactionEnd() {
    if (_interaction) {
      _interaction = false;
      if (stage != null) {
        stage.removeEventListener(MouseEvent.MOUSE_MOVE, _onStageMouseMove);
        stage.removeEventListener(MouseEvent.MOUSE_UP, _onStageMouseUp);
      }

      dispatchEvent(new SliderEvent(SliderEvent.INTERACTION_END, _value));

      if (_momentumEnabled) {
        removeEventListener(Event.ENTER_FRAME, _calcMomentum);
        if (_snapToPage) {
          if (!_isTweening) snapToCurrentPage();
        } else if (_bounce) {
          if (!checkOuterFrame() && !_isTweening) momentumStart();
        } else momentumStart();
      } else {
        if (_snapToPage) {
          if (!_isTweening) snapToCurrentPage();
        } else if (_bounce) {
          if (!checkOuterFrame() && !_isTweening) momentumStart();
        } else if (!_isTweening) {
          changeEnd();
        }
      }
    }
  }


  void pageUp() {
    if (_snapToPage) {
      scrollToPage(_pageStepper.value - 1);
    } else {
      changeStart();
      num val = max(0, value - _pageScrollDistance);
      if (_pageScrollDuration == 0) {
        value = val;
        changeEnd();
      } else {
        _isTweening = true;
        stage.juggler.delayCall(() {
          this.value = val;
          _onTweenComplete();
        }, _pageScrollDuration);

        _scrollTransition(val);

      }
    }
  }


  void pageDown() {
    if (_snapToPage) {
      scrollToPage(_pageStepper.value + 1);
    } else {
      changeStart();
      num val = min(_max, value + _pageScrollDistance);
      if (_pageScrollDuration == 0) {
        value = val;
        changeEnd();
      } else {
        _isTweening = true;
        stage.juggler.delayCall(() {
          this.value = val;
          _onTweenComplete();
        }, _pageScrollDuration);
        
        _scrollTransition(val);
      }
    }
  }


  void scrollToPage(int page, [num offset = 0, bool force = false]) {
    _pageStepper.jumpTo(page);
    if (page == _pageStepper.value || offset != 0 || force) {
      changeStart();
      num val = _pageStepper.value * _pageScrollDistance + offset;
      if (_pageScrollDuration == 0) {
        value = val;
        changeEnd();
      } else {
        _isTweening = true;
        stage.juggler.delayCall(() {
          this.value = val;
          _onTweenComplete();
        }, _pageScrollDuration);
        
        _scrollTransition(val);
      }
    }
  }


  int get currentPage {
    return _pageStepper.jumpTo((_value / _pageScrollDistance).round());
  }


  num get _rawPagePos {
    return _value / _pageScrollDistance;
  }


  void _startPageScrollTimer() {
    _pageScroll();
    _runTimer(firstPageScrollIntervall);
  }


  void _stopPageScrollTimer() {
    if (_timer != null) {
      _timer.cancel();
    }
  }


  void _pageScroll() {
    if (_snapToPage) {
      int thumbPos = ((currentPage * _pageScrollDistance - _min) / (_max - _min) * (_size - _thumbSize)).round();
      if (thumbPos > (_ori ? mouseX : mouseY)) pageUp(); else if (thumbPos + _thumbSize < (_ori ? mouseX : mouseY)) pageDown();
    } else {
      if ((_ori ? _thumb.x : _thumb.y) > (_ori ? mouseX : mouseY)) pageUp(); else if ((_ori ? _thumb.x : _thumb.y) + _thumbSize < (_ori ? mouseX : mouseY)) pageDown();
    }
  }


  void _onTimer(Timer timer) {
    _runTimer(pageScrollIntervall);
    _pageScroll();
  }


  @override
  void _onThumbMouseDown(MouseEvent event) {
    killPageTween();
    super._onThumbMouseDown(event);
  }


  void killPageTween() {
    if (_pageScrollDuration != 0) {
      //value = 0;
      _isTweening = false;
    }
  }


  @override
  void _onBackgroundMouseDown(MouseEvent event) {
    interactionStart(true, false);
    stage.addEventListener(MouseEvent.MOUSE_UP, _onStageMouseUp);
    _startPageScrollTimer();
  }


  @override
  void _onStageMouseUp(MouseEvent event) {
    _stopPageScrollTimer();
    interactionEnd();
  }


  /**
		 * 
		 * MOMENTUM
		 *  
		 */
  @override
  void _applyMomentum(Event event) {
    _momentum *= momentumFriction;
    if ((_momentum).abs() < momentumClearThreshold) {
      // Stop momentum
      value += _momentum;
      clearMomentum();
      if (_value < _min) value = _min; else if (_value > _max) value = _max;
      momentumEnd();
    } else {
      // Apply momentum
      value += _momentum;
      if (!_bounce) {
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
  }


  void snapToCurrentPage() {
    if (_momentum < 0) scrollToPage(currentPage - (_rawPagePos - currentPage < 0 ? 1 : 0), 0, true); else if (_momentum > 0) scrollToPage(currentPage + (_rawPagePos - currentPage > 0 ? 1 : 0), 0, true); else scrollToPage(currentPage);
  }


  bool checkOuterFrame() {
    if (_value < _min) {
      scrollToPage(0);
      return true;
    } else if (_value > _max) {
      scrollToPage((pages).ceil(), 0, true);
      return true;
    }
    return false;
  }


  num get pages {
    return _pages;
  }


  void set pages(num pages) {
    if (pages != _pages) {
      _pages = max(pages, 1);
      _pageStepper.max = _pages - 1;
      _pageScrollDistance = _max / (_pages < 2 ? 1 : _pages - 1);
      _thumbSize = max(10, (_size / _pages).round());
      _ori ? _thumb.width = _thumbSize : _thumb.height = _thumbSize;
//				render();
    }
  }


  @override
  void set value(num newValue) {
    print("value set: $value");
    if (newValue < _min) newValue = _bounce ? _min + (newValue - _min) * 0.5 : _min; else if (newValue > _max) newValue = _bounce ? _max + (newValue - _max) * 0.5 : _max;
    if (!_continuous && newValue != null) newValue = (newValue).round();

    if (newValue != _value) {
      _value = newValue;
      redraw();
      dispatchEvent(new SliderEvent(SliderEvent.VALUE_CHANGE, _value));
    }
  }


  @override
  void redraw() {
    int pos;
    int offset;
    int maxPos;
    int thumbSize;
    maxPos = (_size - _thumbSize).round();
    pos = ((_value - _min) / ((_max - _min) == 0 ? 1 : (_max - _min)) * maxPos).round();
    if (pos < 0) {
      offset = -pos;
      thumbSize = max(10, (_size / _pages).round() - offset * 4);
      pos = 0;
    } else if (pos > maxPos) {
      offset = pos - maxPos;
      thumbSize = max(10, (_size / _pages).round() - offset * 4);
      pos = _size - thumbSize;
    } else {
      offset = 0;
      thumbSize = max(10, (_size / _pages).round() - offset * 4);
    }
    _thumbSize = thumbSize;

    _ori ? _thumb.width = _thumbSize : _thumb.height = _thumbSize;
    _ori ? _thumb.x = pos : _thumb.y = pos;

  }


  @override
  void set maxValue(num maxi) {
    super.maxValue = max(0, (maxi).round());
    _pageScrollDistance = _max / (_pages < 2 ? 1 : _pages - 1);
  }


  bool get snapToPage {
    return _snapToPage;
  }


  void set snapToPage(bool value) {
    _snapToPage = value;
  }


  bool get bounce {
    return _bounce;
  }


  void set bounce(bool value) {
    _bounce = value;
  }
  
  void _runTimer(int delay) {
    if (_timer != null) {
      _timer.cancel();
    }
    _timer = new Timer.periodic(new Duration(milliseconds: delay), _onTimer);
  }

  void _scrollTransition(num val) {
    Transition t = new Transition(value, val, _pageScrollDuration, TransitionFunction.easeOutExponential)
        ..onUpdate = _onPageScrollUpdate
        ..onComplete = _onTweenComplete;
    stage.juggler.add(t);
  }
  void _onPageScrollUpdate(num val) {
    value = val;
  }

  void _onTweenComplete() {
    _isTweening = false;
    changeEnd();
  }
}


