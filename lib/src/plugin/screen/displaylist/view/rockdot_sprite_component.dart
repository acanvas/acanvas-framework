part of rockdot_dart;

class RockdotSpriteComponent extends SpriteComponent implements IApplicationContextAware {

  IApplicationContext _context;
  @override
  IApplicationContext get applicationContext => _context;

  @override
  void set applicationContext(IApplicationContext ctx) {
    _context = ctx;
  }

  RockdotSpriteComponent() : super() {
      RockdotContextHelper.wire(this);
  }

  String getProperty(String key, [bool omitPrefix = false]) {
    key = (omitPrefix ? "" : name + ".") + key;
    String str = _context.propertiesProvider.getProperty(key);
    if (str == "") {
      str = key;
    }

    return str;
  }

}
