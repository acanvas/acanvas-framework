part of rockdot_dart;

class RockdotManagedSpriteComponent extends ManagedSpriteComponent implements IManagedSpriteComponent, IApplicationContextAware {

  RockdotApplicationContext _context;

  RockdotManagedSpriteComponent(String id) : super(id) {
    _ignoreCallSetSize = true;
  }

  String getProperty(String key, [bool omitPrefix = false]) {
    key = (omitPrefix ? "" : name + ".") + key;
    String str = _context.propertiesProvider.getProperty(key);
    if (str == "") {
      str = key;
    }

    return str;
  }

  @override
  void appear([num duration = 0.5]) {
    super.appear(duration);
    new Timer(new Duration(milliseconds: (duration * 100).toInt()), onAppear);
  }

  @override
  void disappear([num duration = 0.5, bool autoDestroy = false]) {
    super.disappear(duration, autoDestroy);
    new Timer(new Duration(milliseconds: (duration * 100).toInt()), onDisappear);
  }

  // TODO: implement applicationContext
  @override
  IApplicationContext get applicationContext => _context;

  @override
  void set applicationContext(IApplicationContext ctx) {
    _context = ctx;
  }
}
