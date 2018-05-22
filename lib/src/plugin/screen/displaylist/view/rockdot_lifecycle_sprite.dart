part of rockdot_framework.screen;

class RockdotLifecycleSprite extends LifecycleSprite
    with MApplicationContextAware {
  RockdotLifecycleSprite(String id) : super(id) {
    RdContextUtil.wire(this);
    inheritSpan = false;
  }

  @override
  String getProperty(String key,
      [bool omitPrefix = false, String prefix = ""]) {
    return super.getProperty(key, omitPrefix, this.name);
  }
}
