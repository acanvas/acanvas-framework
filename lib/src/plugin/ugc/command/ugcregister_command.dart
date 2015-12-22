part of rockdot_framework.ugc;

//@retain
class UGCRegisterCommand extends AbstractUGCCommand implements IFBModelAware {
  FBModel _fbModel;

  void set fbModel(FBModel fbModel) {
    _fbModel = fbModel;
  }

  @override void execute([RdSignal event = null]) {
    super.execute(event);
//			dispatchMessage("loading.backend.login");

    if (event.data is UGCUserDTO) {

      _ugcModel.userDAO = event.data;

    } else if (RdConstants.LOCAL && RdConstants.DEBUG) {

      _ugcModel.userDAO = _createDummyData();

    } else if (_ugcModel.userDAO == null) {

      UGCUserDTO user = new UGCUserDTO();
      user.network = UGCUserDTO.NETWORK_FACEBOOK;
      user.name = _fbModel.user.name;
      user.pic = _fbModel.user.pic_square;
      user.uid = _fbModel.user.uid;
      user.locale = _fbModel.user.locale;
      _ugcModel.userDAO = user;
    }

    _ugcModel.userDAO.device = html.window.navigator.platform;

    amfOperation("UGCEndpoint.login", dto: _ugcModel.userDAO);
  }


  UGCUserDTO _createDummyData() {
    UGCUserDTO user = new UGCUserDTO();
    user.network = UGCUserDTO.NETWORK_INPUTFORM;
    user.name = "Fake User";
    user.pic = "http://profile.ak.fbcdn.net/static-ak/rsrc.php/v1/yo/r/UlIqmHJn-SK.gif";
    user.uid = "1234-fake";
    user.locale = "de_DE";

    return user;
  }
}
