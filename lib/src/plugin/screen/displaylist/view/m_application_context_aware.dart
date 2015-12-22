part of rockdot_framework.screen;

abstract class MApplicationContextAware implements IApplicationContextAware {

  RdContext _context;

  @override IApplicationContext get applicationContext => _context;

  @override void set applicationContext(IApplicationContext ctx) {
    _context = ctx;
  }

  String getProperty(String key, [bool omitPrefix = false, String name = ""]) {
    key = (omitPrefix ? "" : name + ".") + key;
    String str = _context.propertiesProvider.getProperty(key);
    if (str == "" || str == null) {
      str = key;
    }

    return str;
  }

}
