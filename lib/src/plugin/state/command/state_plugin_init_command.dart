part of acanvas_framework.state;

class StatePluginInitCommand extends AbstractStateCommand {
  @override
  dynamic execute([AcSignal event = null]) {
    super.execute(event);

    _stateModel.addressService = new SWFAddressService();

    dispatchCompleteEvent();
    return null;
  }
}
