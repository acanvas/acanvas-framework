part of rockdot_dart;


/**
	 * Copyright (2012 as c), Jung von Matt/Neckar
	 * All rights reserved.
	 *
	 * @author danielhuebschmann
	 * @since 16.01.2012 18:32:51
	 */
class DayButton extends Button {

  UITextField _labelTF;
  int _tag;
  Shape _bgOver;

  DayButton(String label, int w, int h) : super() {
    mouseChildren = false;


    _bgOver = new Shape();
    createBG(_bgOver, 0xFFFFE93F, w, h);
    _bgOver.alpha = 0;

    Shape bg = new Shape();
    createBG(bg, 0xFF000000, w, h);

    TextFormat fm = new TextFormat("Arial", 18, 0xFFFFFFFF);
    fm.align = TextFormatAlign.CENTER;

    _labelTF = new UITextField(label, fm);
    _labelTF.width = w;
    _labelTF.wordWrap = true;
    _labelTF.multiline = false;
    _labelTF.height = h;
    _labelTF.autoSize = TextFieldAutoSize.CENTER;
    addChild(_labelTF);

    _labelTF.y = (h * .5 - _labelTF.height * .5).floor();
  }

  @override void onRollOver([MouseEvent event = null]) {
    if (stage != null) {
      //stage.juggler.removeTweens(_bgOver);
      stage.juggler.tween(_bgOver, 0.3)..animate.alpha.to(1);
      _labelTF.textColor = 0xFF000000;
    } else if (_bgOver != null) {
      _bgOver.alpha = 1;
    }
  }

  @override void onRollOut([MouseEvent event = null]) {
    if (stage != null) {
      stage.juggler.tween(_bgOver, 0.3 )..animate.alpha.to(0);
      _labelTF.textColor = 0xFFFFFFFF;
    } else if (_bgOver != null) {
      _bgOver.alpha = 0;
    }
  }


  String get label {
    return _labelTF.text;
  }

  void set label(String value) {
    _labelTF.text = value;
  }

  int get tag {
    return _tag;
  }

  void set tag(int tag) {
    _tag = tag;
  }
}
