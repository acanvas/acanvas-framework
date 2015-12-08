part of stagexl_rockdot.state;


/**
 * @author Nils Doehring (nilsdoehring(gmail as at).com)
 */
//@retain
class StateAddressSetCommand extends AbstractStateCommand {
  @override dynamic execute([RdSignal event=null]) {
    super.execute(event);
    _stateModel.addressService.changeAddress(event.data, dispatchCompleteEvent);
    return null;
  }
}

