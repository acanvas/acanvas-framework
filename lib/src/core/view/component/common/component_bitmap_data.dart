part of rockdot_dart;




/**
	 * Copyright (2010 as c), Jung von Matt/Neckar
	 * All rights reserved.
	 */

class ComponentBitmapData extends SpriteComponent {
  Rectangle _innerRect;
  BitmapData _bitmapDataSource;
  BitmapData _bitmapDataTarget;
  Bitmap _targetBitmap;
  ComponentBitmapData(BitmapData bitmapData, [Rectangle innerRect = null]) : super() {
    _bitmapDataSource = bitmapData;
    _innerRect = innerRect;
  }

  @override
  void redraw() {
    num scale;
    if (_bitmapDataSource.width > _bitmapDataSource.height) {
      scale = _heightAsSet / _bitmapDataSource.height;
    } else {
      scale = _widthAsSet / _bitmapDataSource.width;
    }
    
    int targetWidth = (_bitmapDataSource.width*scale).ceil(); 
    int targetHeight = (_bitmapDataSource.height*scale).ceil(); 

    _bitmapDataTarget = new BitmapData(targetWidth, targetHeight, false);
    _bitmapDataTarget.draw(_bitmapDataSource, new Matrix(scale, 0, 0, scale, 0, 0));
    
    if(_targetBitmap!=null){
      if(_targetBitmap.parent != null){
        removeChild(_targetBitmap);
      }
      _targetBitmap.bitmapData.clear();
      _targetBitmap = null;
    }
    _targetBitmap = new Bitmap(_bitmapDataTarget);
    addChild(_targetBitmap);

    super.redraw();
  }

  @override
  void destroy() {
    super.destroy();
    graphics.clear();
//			_bitmapData.dispose();
  }
}
