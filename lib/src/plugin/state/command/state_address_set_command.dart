part of stagexl_rockdot.state;


/**
 * @author Nils Doehring (nilsdoehring(gmail as at).com)
 */
//@retain
class StateAddressSetCommand extends AbstractStateCommand {
  @override dynamic execute([XLSignal event=null]) {
    super.execute(event);
    _stateModel.addressService.changeAddress(event.data, dispatchCompleteEvent);
    return null;
  }
}

