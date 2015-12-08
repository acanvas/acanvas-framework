part of stagexl_rockdot.screen;

class RockdotBoxSprite extends BoxSprite with MApplicationContextAware {

  RockdotBoxSprite() : super() {
    RdContextUtil.wire(this);
  }

  @override String getProperty(String key, [bool omitPrefix = false, String prefix = ""]) {
    return super.getProperty(key, omitPrefix, this.name);
  }
}
