part of rockdot_dart;


/**
	 * Copyright (2012 as c), Jung von Matt/Neckar
	 * All rights reserved.
	 *
	 * @author danielhuebschmann
	 * @since 16.01.2012 19:02:44
	 */
class NextPrevButton extends Button {

  UITextField _labelTF;
  NextPrevButton(String label, int w, int h) : super() {
    mouseChildren = false;

    Shape bg = new Shape();
    bg.graphics.rect(0, 0, w, h);
    bg.graphics.fillColor(0x66000000);
    if (RockdotConstants.WEBGL) {
      bg.applyCache(0, 0, w, h);
    }
    addChild(bg);

    TextFormat fm = new TextFormat("Arial", 18, 0xFFFFFF);
    fm.align = TextFormatAlign.CENTER;

    _labelTF = new UITextField(label, fm);
    _labelTF.width = w;
    _labelTF.wordWrap = true;
    _labelTF.multiline = false;
    _labelTF.height = h;
    _labelTF.autoSize = TextFieldAutoSize.CENTER;
    addChild(_labelTF);

    _labelTF.y = ( h*.5 - _labelTF.textHeight*.5 ).floor();
  }
}
