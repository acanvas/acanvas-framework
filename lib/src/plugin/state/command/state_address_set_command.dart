part of rockdot_framework.state;

/**
 * @author Nils Doehring (nilsdoehring(gmail as at).com)
 */

class StateAddressSetCommand extends AbstractStateCommand {
  @override
  dynamic execute([RdSignal event = null]) {
    super.execute(event);
    _stateModel.addressService.changeAddress(event.data, dispatchCompleteEvent);
    return null;
  }
}
