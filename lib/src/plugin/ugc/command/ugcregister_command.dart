part of rockdot_dart;



@retain
class UGCRegisterCommand extends AbstractUGCCommand implements IFBModelAware {
  FBModel _fbModel;
  void set fbModel(FBModel fbModel) {
    _fbModel = fbModel;
  }

  @override dynamic execute([RockdotEvent event = null]) {
    super.execute(event);
//			dispatchMessage("loading.backend.login");

    if (event.data is UGCUserVO) {
      _ugcModel.userDAO = event.data;
    } else if (RockdotConstants.LOCAL && RockdotConstants.DEBUG) {
      _ugcModel.userDAO = _createDummyData();
    } else if (_ugcModel.userDAO == null) {
      UGCUserVO user = new UGCUserVO();
      user.network = UGCUserVO.NETWORK_FACEBOOK;
      user.name = _fbModel.user.name;
      user.pic = _fbModel.user.pic_square;
      user.uid = _fbModel.user.uid;
      user.locale = _fbModel.user.locale;
      _ugcModel.userDAO = user;
    }
    _ugcModel.userDAO.device = Capabilities.os;
    amfOperation("UGCEndpoint.login", [_ugcModel.userDAO]);
  }
  UGCUserVO _createDummyData() {
    UGCUserVO user = new UGCUserVO();
    user.network = UGCUserVO.NETWORK_INPUTFORM;
    user.name = "Fake User";
    user.pic = "http://profile.ak.fbcdn.net/static-ak/rsrc.php/v1/yo/r/UlIqmHJn-SK.gif";
    user.uid = "1234-fake";
    user.locale = "de_DE";

    return user;
  }


}
