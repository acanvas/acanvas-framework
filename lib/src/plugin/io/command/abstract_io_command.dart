part of rockdot_framework.io;

class AbstractIOCommand extends RdCommand implements IIOModelAware {

  IOModel _ioModel;

  @override
  void set ioModel(IOModel ioModel) {
    _ioModel = ioModel;
  }

  IOModel get ioModel => _ioModel;
}