part of acanvas_framework.state;

/**
 * @author Nils Doehring (nilsdoehring(gmail as at).com)
 */

class StateAddressSetCommand extends AbstractStateCommand {
  @override
  dynamic execute([AcSignal event = null]) {
    super.execute(event);
    _stateModel.addressService.changeAddress(event.data, dispatchCompleteEvent);
    return null;
  }
}
