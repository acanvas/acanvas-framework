part of rockdot_framework.ugc;

class UGCModel {
  UGCUserDTO _userDAO;
  UGCUserExtendedDTO _userSweepstakeDAO;

  List _taskCategories;
  bool _hasUserExtendedDAO;

  void set taskCategories(List newTaskCategories) {
    _taskCategories = newTaskCategories;
  }

  List get taskCategories {
    return _taskCategories;
  }

  List _loadedTasks;

  void set loadedTasks(List loadedTasks) {
    _loadedTasks = loadedTasks;
  }

  List get loadedTasks {
    return _loadedTasks;
  }

  List _ownContainers;

  void set ownContainers(List newOwnContainers) {
    _ownContainers = newOwnContainers;
  }

  List get ownContainers {
    return _ownContainers;
  }

  List _followContainers;

  void set followContainers(List newContainers) {
    _followContainers = newContainers;
  }

  List get followContainers {
    return _followContainers;
  }

  List _participantContainers;

  void set participantContainers(List newContainers) {
    _participantContainers = newContainers;
  }

  List get participantContainers {
    return _participantContainers;
  }

  //these are detailed DB reads
  UGCItemDTO _currentItemDAO;

  List _friendsWithPhotosUIDs;
  bool _initialized;
  bool _alternateLogin;

  /***********************************************************************
   * Gaming Model
   ***********************************************************************/

  UGCGamingModel _gaming;

  UGCGamingModel get gaming {
    return _gaming;
  }

  void set gaming(UGCGamingModel gaming) {
    _gaming = gaming;
  }

  /***********************************************************************
   * UserDAO
   ***********************************************************************/
  UGCUserDTO get userDAO {
    return _userDAO;
  }

  void set userDAO(UGCUserDTO userDAO) {
    _userDAO = userDAO;
  }

  UGCUserExtendedDTO get userExtendedDAO {
    return _userSweepstakeDAO;
  }

  void set userExtendedDAO(UGCUserExtendedDTO userSweepstakeDAO) {
    _userSweepstakeDAO = userSweepstakeDAO;
  }

  /***********************************************************************
   * GALLERY - DAO
   ***********************************************************************/
  UGCItemDTO get currentItemDAO {
    return _currentItemDAO;
  }

  void set currentItemDAO(UGCItemDTO currentItemDAO) {
    _currentItemDAO = currentItemDAO;
  }

  List get friendsWithUGCItems {
    return _friendsWithPhotosUIDs;
  }

  void set friendsWithUGCItems(List galleryFriendList) {
    _friendsWithPhotosUIDs = galleryFriendList;
  }

  bool get initialized {
    return _initialized;
  }

  void set initialized(bool initialized) {
    _initialized = initialized;
  }

  bool get alternateLogin {
    return _alternateLogin;
  }

  void set alternateLogin(bool alternateLogin) {
    _alternateLogin = alternateLogin;
  }

  dynamic _service;

  void set service(dynamic service) {
    _service = service;
  }

  dynamic get service {
    return _service;
  }

  UGCModel() {
    gaming = new UGCGamingModel();
  }

  //ignore: unused_element
  List _convertDateTime(List entries) {
    for (int i = 0; i < entries.length; i++) {
      Map vo = entries[i];

      if (!vo.containsKey("datetime")) return entries;

      List datetime = vo["datetime"].split(" ");
      List date = datetime[0].split("-");
      List time = datetime[1].split(":");
      entries[i].date = date[2];
      entries[i].month = date[1];
      entries[i].year = date[0];
      entries[i].time = time[0] + ":" + time[1];
    }

    return entries;
  }

  UGCItemContainerDTO _currentItemContainerDAO;

  UGCItemContainerDTO get currentItemContainerDAO {
    return _currentItemContainerDAO;
  }

  void set currentItemContainerDAO(
      UGCItemContainerDTO currentItemContainerDAO) {
    _currentItemContainerDAO = currentItemContainerDAO;
  }

  UGCItemContainerDTO _loadedItemContainerDAO;

  UGCItemContainerDTO get loadedItemContainerDAO {
    return _loadedItemContainerDAO;
  }

  void set loadedItemContainerDAO(UGCItemContainerDTO loadedItemContainerDAO) {
    _loadedItemContainerDAO = loadedItemContainerDAO;
  }

  bool get hasUserExtendedDAO {
    return _hasUserExtendedDAO;
  }

  void set hasUserExtendedDAO(bool hasUserExtendedDAO) {
    _hasUserExtendedDAO = hasUserExtendedDAO;
  }
}
