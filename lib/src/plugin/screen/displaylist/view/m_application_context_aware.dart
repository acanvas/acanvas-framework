part of acanvas_framework.screen;

abstract class MApplicationContextAware implements IApplicationContextAware {
  AcContext _context;

  @override
  IApplicationContext get applicationContext => _context;

  @override
  void set applicationContext(IApplicationContext ctx) {
    _context = ctx;
  }

  String getProperty(String key,
      [bool omitPrefix = false, String prefix = ""]) {
    if (_context == null) {
      return "no context";
    }
    key = (omitPrefix ? "" : prefix + ".") + key;
    String str = _context.propertiesProvider.getProperty(key);
    if (str == "" || str == null) {
      str = key;
    }

    return str;
  }
}
