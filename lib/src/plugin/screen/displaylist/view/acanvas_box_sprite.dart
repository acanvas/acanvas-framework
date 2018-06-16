part of acanvas_framework.screen;

class AcanvasBoxSprite extends BoxSprite with MApplicationContextAware {
  AcanvasBoxSprite() : super() {
    AcContextUtil.wire(this);
  }

  @override
  String getProperty(String key,
      [bool omitPrefix = false, String prefix = ""]) {
    return super.getProperty(key, omitPrefix, this.name);
  }
}
