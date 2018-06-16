part of acanvas_framework.io;

class AbstractIOCommand extends AcCommand implements IIOModelAware {
  IOModel _ioModel;

  @override
  void set ioModel(IOModel ioModel) {
    _ioModel = ioModel;
  }

  IOModel get ioModel => _ioModel;
}
