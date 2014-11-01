part of stagexl_rockdot;

@retain
class UGCRegisterExtendedCommand extends AbstractUGCCommand implements IFBModelAware {
  FBModel _modelFB;
  void set fbModel(FBModel model) {
      _modelFB = model;
    }
 
  @override void execute([XLSignal event = null]) {
    super.execute(event);
//			dispatchMessage("loading.backend.login");

    UGCUserExtendedDTO amfObject;

    if (event.data is UGCUserExtendedDTO) {
      
      amfObject = event.data;
      _ugcModel.userExtendedDAO = new UGCUserExtendedDTO(amfObject.toJson());
      
    } else if (RockdotConstants.LOCAL && RockdotConstants.DEBUG) {
      
      _ugcModel.userExtendedDAO = _createDummyData();
      amfObject = _ugcModel.userExtendedDAO;
      
    } else if (_ugcModel.userExtendedDAO == null) {
      
      UGCUserExtendedDTO user = new UGCUserExtendedDTO();
      user.hometown_location = _modelFB.user.hometown_location;
      user.email = _modelFB.user.email;
      user.email_confirmed = 1;
      user.birthday_date = _modelFB.user.birthday_date;
      user.firstname = "";
      user.lastname = "";
      user.street = "";
      user.city = "";
      _ugcModel.userExtendedDAO = user;
      amfObject = _ugcModel.userExtendedDAO;
    }

    _ugcModel.userExtendedDAO.uid = _ugcModel.userDAO.uid;
    amfObject.uid = _ugcModel.userExtendedDAO.uid;
    _ugcModel.userExtendedDAO.hash = (new Random().nextDouble() * getTimeInMilliseconds(new DateTime.now())).toString();
    amfObject.hash = _ugcModel.userExtendedDAO.hash;

    _ugcModel.hasUserExtendedDAO = true;
    amfOperation("UGCEndpoint.createUserExtended", dto: amfObject);
  }
  
  UGCUserExtendedDTO _createDummyData() {
    UGCUserExtendedDTO user = new UGCUserExtendedDTO();
    user.hometown_location = "Stuttgart, Germany";
    user.email = "anna-maria.fincke@jvm-neckar.de";
    user.email_confirmed = 1;
    user.birthday_date = "1981-12-24";
    user.title = "Ms";
    user.firstname = "Anna-Maria";
    user.lastname = "Fincke";
    user.street = "Neckarstraße 155";
    user.city = "70190 Stuttgart";
    user.country = "DE";
    return user;
  }

  num getTimeInMilliseconds(DateTime date) {
    return date.hour * 60 * 60 * 1000 + date.minute * 60 * 1000 + date.second * 1000 + date.millisecond;
  }

  
}
