part of acanvas_framework.io;

/**
 * <code>IObjectPostProcessor</code> implementation that checks for objects that implement the <code>IApplicationContextAware</code>
 * abstract class and injects them with the provided <code>IApplicationContext</code> instance.
 * <p>
 * <b>Author:</b> Christophe Herreman<br/>
 * <b>Version:</b> $Revision: 21 $, $Date: 2008-11-01 22:58:42 +0100 (za, 01 nov 2008) $, $Author: dmurat $<br/>
 * <b>Since:</b> 0.1
 * </p>
 * @inheritDoc
 */
class IOModelInjector implements IObjectPostProcessor {
  IObjectFactory _applicationContext;

  IOModelInjector(IObjectFactory applicationContext) {
    _applicationContext = applicationContext;
  }

  /**
   * @inheritDoc
   */
  dynamic postProcessAfterInitialization(dynamic object, String objectName) {
    if (object is IIOModelAware) {
      object.ioModel = _applicationContext.getObject(IOPlugin.MODEL_IO);
    }

    return object;
  }

  dynamic postProcessBeforeInitialization(dynamic object, String objectName) {
    return object;
  }
}
