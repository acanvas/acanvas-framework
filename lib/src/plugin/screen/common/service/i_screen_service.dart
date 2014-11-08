part of stagexl_rockdot;

/**
 * @author nilsdoehring
 */

abstract class IScreenService {
  bool get initialized;
  ManagedSpriteComponent get background;
  ManagedSpriteComponent get content;
  ManagedSpriteComponent get navi;
  ManagedSpriteComponent get layer;
  ManagedSpriteComponent get foreground;
  Stage get stage;
  BitmapFilter get modalBackgroundFilter;
  void set modalBackgroundFilter(BitmapFilter filter);
  void init([Function callback = null]);
  void resize([Event event = null]);
  void lock();
  void unlock();
  void blur();
  void unblur();
  bool get isBlurred;
  void set isBlurred(bool blurred);

}
