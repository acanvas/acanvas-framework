part of rockdot_dart;





/**
	 * @author nilsdoehring
	 */
@retain
class BasicEffect implements IEffect {

  String _type;
  String get type {
    return _type;
  }
  void set type(String type) {
    _type = type;
  }

  num _initialAlpha;
  num get initialAlpha {
    return _initialAlpha;
  }
  void set initialAlpha(num initialAlpha) {
    _initialAlpha = initialAlpha;
  }

  num _duration;
  void set duration(num duration) {
    _duration = duration;
  }
  num get duration {
    return _duration;
  }

  Sprite _sprite;
  void set sprite(Sprite sprite) {
    _sprite = sprite;
  }
  Sprite get sprite {
    return _sprite;
  }

  bool _useSprite;
  bool useSprite() {
    return _useSprite;
  }

  bool _applyRecursively;
  bool get applyRecursively {
    return _useSprite == true ? false : _applyRecursively;
  }

  Stage _stage;

  BasicEffect() {
    _stage = RockdotConstants.getStage();
    _duration = 0.5;
    _applyRecursively = false;
    _useSprite = false;
  }
  Bitmap _registerBitmapSprite(ISpriteComponent target) {

    Sprite spr = target as Sprite;
    
    _applyRecursively = false;

    spr.alpha = 1;
    Rectangle rect = spr.getBounds(_stage);

    BitmapData output = new BitmapData(rect.width + 20, rect.height + 20, true, 0x00000000);
    Matrix mat = spr.transformationMatrix != null ? spr.transformationMatrix : new Matrix(0,0,0,0,0,0);
    _sprite.x = mat.tx;
    _sprite.y = mat.ty;

    mat.setTo(mat.a, mat.b, mat.c, mat.d, 0, 0);
    output.draw(target as DisplayObject, mat);

    Bitmap outputBmp = new Bitmap(output);
    outputBmp.applyCache(0, 0, output.width, output.height);
    target.alpha = 0;

    _sprite.addChild(outputBmp);
    return outputBmp;

  }


  //These two are the only methods you'll need to override @see BitmapAlphaEffect.
  void runInEffect(ISpriteComponent target, num duration, Function callback) {
    target.alpha = 0;

    var tween = new Tween(target as DisplayObject, duration, TransitionFunction.easeInCubic);
    tween.animate.alpha.to(1.0); // target value = 0.0
    tween.onComplete = () => callback(callback);
    _stage.juggler.add(tween);
    
  }
  void runOutEffect(ISpriteComponent target, num duration, Function callback) {
    //target.visible = true;
    target.alpha = 1;

    var tween = new Tween(target as DisplayObject, duration, TransitionFunction.easeInCubic);
    tween.animate.alpha.to(0); // target value = 0.0
    tween.onComplete = () => callback(callback);
    _stage.juggler.add(tween);
  }
  
  void cancel([ISpriteComponent target = null]) {
    if (target == null) return;
    
    _stage.juggler.removeTweens(target as DisplayObject);

    DisplayObject child;
    for (int i = 0; i < (target as DisplayObjectContainer).numChildren; i++) {
      child = (target as DisplayObjectContainer).getChildAt(i);
      if (child is ISpriteComponent) {
        cancel(child as ISpriteComponent);
      }
    }
  }
  void onComplete([Bitmap target = null, ISpriteComponent page = null, Function callback = null]) {
    _stage.juggler.removeTweens(target);

    if (target != null) {
      if (target.parent != null) {
        target.parent.removeChild(target);
      }
      target.bitmapData.clear();
    }

    if (page != null) {
      page.alpha = 1;
    }

    if (callback != null) {
      callback.call(null);
    }
  }
  void destroy() {
    if (_sprite != null && useSprite()) {
      _stage.juggler.removeTweens(_sprite);
      if (_sprite.parent != null) {
        _sprite.parent.removeChild(_sprite);
      }
      _sprite = null;
    }
  }
}

_callback(Function callback) {
  callback.call();
}
