part of stagexl_rockdot.state;


//@retain
class StatePluginInitCommand extends AbstractStateCommand {

  @override dynamic execute([RdSignal event=null]) {
    super.execute(event);

    _stateModel.addressService = new SWFAddressService();

    dispatchCompleteEvent();
    return null;
  }
}

