part of rockdot_dart;


class ComponentDropdown extends RockdotSpriteComponent {
  static const String ROLLOUT_OPEN = "OPEN";
  static const String ROLLOUT_CLOSE = "CLOSE";

  SpriteComponent _sprRollout;
  Button btnRolloutToggle;
  ComponentList cmpListFlyout;
  bool _blnMirrorButtonOnToggle = false;

  String _strRolloutState;
  Function _onToggleCallback;
  ComponentDropdown() : super() {
  }

  void superConstructor() {
    _sprRollout = new SpriteComponent();
    addChild(_sprRollout);

    if (cmpListFlyout != null) {
      cmpListFlyout.submitCallback = _onCellSubmit;
      _sprRollout.addChild(cmpListFlyout);
      //dartcomment 
      //cmpListFlyout.redraw();
    }

    _strRolloutState = ROLLOUT_CLOSE;

    btnRolloutToggle.submitCallback = toggleRollout;
    addChild(btnRolloutToggle);
  }

  void setListSizeMax(int w, int h) {
    if (cmpListFlyout != null) {
      cmpListFlyout.setSize(w, h);
    }
  }

  @override
  void redraw() {
    super.redraw();

    btnRolloutToggle.setSize(widthAsSet, heightAsSet);

    _sprRollout.x = btnRolloutToggle.x + widthAsSet - _sprRollout.width + 43;
    _sprRollout.y = -_sprRollout.height;

    this.mask = new Mask.rectangle(0, 0, _sprRollout.width + 20, _sprRollout.height + 2);
  }

  void toggleRollout([MouseEvent event = null]) {
    if (_strRolloutState == ROLLOUT_CLOSE) {
      openRollout();
    } else {
      closeRollout();
    }
  }

  void openRollout([MouseEvent event = null]) {
    if (_strRolloutState == ROLLOUT_CLOSE) {
      if (_blnMirrorButtonOnToggle) {
        btnRolloutToggle.scaleY = -1;
        btnRolloutToggle.y = heightAsSet - 1;
      }

      _sprRollout.visible = true;
      _strRolloutState = ROLLOUT_OPEN;
      stage.juggler.tween(_sprRollout, 0.5)..animate.y.to(heightAsSet);
      if (_onToggleCallback != null) {
        _onToggleCallback.call(_strRolloutState);
      }
    }
  }

  void closeRollout([MouseEvent event = null]) {
    if (_strRolloutState == ROLLOUT_OPEN) {
      if (_blnMirrorButtonOnToggle) {
        btnRolloutToggle.scaleY = 1;
        btnRolloutToggle.y = -1;
      }
      _strRolloutState = ROLLOUT_CLOSE;
      stage.juggler.tween(_sprRollout, 0)
          ..animate.y.to(-_sprRollout.height)
          ..onComplete = _onCloseRolloutComplete;
    }
  }

  void _onCloseRolloutComplete() {
    _sprRollout.visible = false;

    if (_onToggleCallback != null) {
      _onToggleCallback.call(_strRolloutState);
    }
  }

  void _onCellSubmit(Cell cell) {

    btnRolloutToggle.setLabel((cell.data));

    if (_submitCallback != null) {
      _submitCallback.call(cell);
    }

    closeRollout();
  }

  void set onToggleCallback(Function onToggleCallback) {
    _onToggleCallback = onToggleCallback;
  }
}
