part of acanvas_framework.state;

/**
 * @author Nils Doehring (nilsdoehring(gmail as at).com)
 */

class StateSetParamsCommand extends AbstractStateCommand {
  @override
  dynamic execute([AcSignal event = null]) {
    super.execute(event);
    StateVO vo = event.data;
    _stateModel.addressService.onAddressChanged(vo);
    if (_stateModel.currentScreen != null) {
      _stateModel.currentScreen.params = vo.params;
    }

    dispatchCompleteEvent();
    return null;
  }
}
