part of stagexl_rockdot.state;

/**
	 * @author Nils Doehring (nilsdoehring(gmail as at).com)
	 */
class SWFAddressService extends BasicAddressService implements IAddressService {
  String _defaultTitle;
  Function _callback;
  SWFAddressService() {
  }

  @override void init() {
    html.window.onHashChange.listen(_onSWFAddressChange);
    _defaultTitle = html.document.title;
    _onSWFAddressChange();
  }

  void _onSWFAddressChange([html.HashChangeEvent e = null]) {
    var hash = html.window.location.hash;
    if (hash.length > 0 && hash[0] == "#") hash = hash.substring(1);
    new XLSignal(StateEvents.STATE_REQUEST, hash, _callback).dispatch();
  }

  @override void changeAddress(String url, [Function callback = null]) {
    _callback = callback;
    if (url.contains("http")) html.window.open(url, "_blank"); else html.window.location.hash = url;
  }

  @override void onAddressChanged(StateVO vo) {

    html.document.title = (_defaultTitle + " - " + vo.title);
    super.onAddressChanged(vo);
  }
}
