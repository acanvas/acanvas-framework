part of acanvas_framework.state;

/**
 * @author Nils Doehring (nilsdoehring(gmail as at).com)
 */
class BasicAddressService implements IAddressService {
  void init() {}

  void changeAddress(String url, [Function callback = null]) {
    new AcSignal(StateEvents.STATE_REQUEST, url).dispatch();
  }

  void onAddressChanged(StateVO vo) {}
}
