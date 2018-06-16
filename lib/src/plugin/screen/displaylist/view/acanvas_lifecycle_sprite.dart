part of acanvas_framework.screen;

class AcanvasLifecycleSprite extends LifecycleSprite
    with MApplicationContextAware {
  AcanvasLifecycleSprite(String id) : super(id) {
    AcContextUtil.wire(this);
    inheritSpan = false;
  }

  @override
  String getProperty(String key,
      [bool omitPrefix = false, String prefix = ""]) {
    return super.getProperty(key, omitPrefix, this.name);
  }
}
