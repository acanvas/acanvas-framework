part of rockdot_dart;



/**
	 * Copyright 2009 Jung von Matt/Neckar
	 */
class ComponentImageLoader extends SpriteComponent {
  Bitmap _img;
  String _href;

  ComponentImageLoader(String href, int w, int h) : super() {
    _widthAsSet = w;
    _heightAsSet = h;
    _href = href;

    if (_href == null) {
      onComplete();
      return;
    }

    if (RockdotConstants.PROTOCOL == "https:") {
      if (_href.indexOf("fbcdn.net") != -1) {
        _href = _href.replaceAll("http://profile.ak.fbcdn.net", "https://fbcdn-profile-a.akamaihd.net");
      } else {
        _href = _href.replaceAll("http:", "https:");
      }
    }
    //print("BitmapData.load: $_href");
    BitmapData.load(_href, new BitmapDataLoadOptions(corsEnabled: true)).then(onComplete).catchError(onIoError);

  }

  void onComplete([BitmapData data = null]) {
    if (data != null) {
      _img = new Bitmap(data);
    } else {
      Shape dobj = new Shape();
      dobj.graphics.rect(0, 0, widthAsSet, heightAsSet);
      dobj.graphics.fillColor(0xffff2222);
      BitmapData bmd = new BitmapData(widthAsSet, heightAsSet);
      bmd.draw(dobj);
      _img = new Bitmap(bmd);
    }

    // calculate and apply scale
    double scale = 0.0;
    if (_img.width > _img.height) {
      scale = _heightAsSet / _img.height;
    } else {
      scale = _widthAsSet / _img.width;
    }
    _img.scaleX = scale;
    _img.scaleY = scale;
    _img.x = (_widthAsSet - _img.width) / 2;
    _img.y = (_heightAsSet - _img.height) / 2;


    Mask mask = new Mask.rectangle(_img.x.abs() / scale, 0, _widthAsSet / scale, _heightAsSet / scale);
    _img.mask = mask;
    addChild(_img);

    dispatchEvent(new Event(Event.COMPLETE, false));
  }


  @override
  int get height {
    return _heightAsSet;
  }
  void onIoError(Error e) {
    print("IO error occured while loading image");
    onComplete();
  }
  /*
		void onSecurityError(SecurityErrorEvent event)
		
		{
			print("Security error occured while loading image"));
			onComplete();
		}
		* */
}
