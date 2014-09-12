part of rockdot_dart;





/**
	 * @author nilsdoehring
	 */

abstract class IEffect {
  void set duration(num duration);
  num get duration;
  void set initialAlpha(num initialAlpha);
  num get initialAlpha;
  void set type(String type);
  String get type;
  bool get applyRecursively;
  void set sprite(Sprite spr);
  Sprite get sprite;
  bool useSprite();
  void runInEffect(ISpriteComponent target, num duration, Function callback);
  void runOutEffect(ISpriteComponent target, num duration, Function callback);
  void cancel([ISpriteComponent target = null]);
  void destroy();
}
