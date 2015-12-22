part of rockdot_framework.screen;

/**
 * @author nilsdoehring
 */

abstract class IScreenService {
  bool get initialized;

  LifecycleSprite get background;

  LifecycleSprite get content;

  LifecycleSprite get navi;

  LifecycleSprite get layer;

  LifecycleSprite get foreground;

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
