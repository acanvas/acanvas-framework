part of rockdot_framework.facebook;

/**
 * @author nilsdoehring
 */
class FBModel {

  js.JsObject _FB;

  void set FB(js.JsObject fbo) {
    _FB = fbo;
  }

  js.JsObject get FB => _FB;

  FBUserVO _user;

  FBUserVO get user {
    return _user;
  }

  void set user(FBUserVO user) {
    _user = user;
  }

  List _userAlbums;

  List get userAlbums {
    return _userAlbums;
  }

  void set userAlbums(List userAlbums) {
    _userAlbums = userAlbums;
  }

  List _userAlbumPhotos;

  List get userAlbumPhotos {
    return _userAlbumPhotos;
  }

  void set userAlbumPhotos(List userAlbumPhotos) {
    _userAlbumPhotos = userAlbumPhotos;
  }

  bool _userIsAuthenticated = false;

  bool get userIsAuthenticated {
    return _userIsAuthenticated;
  }

  List _invitedUsers;

  void set invitedUsers(List newInvitedUsers) {
    _invitedUsers = newInvitedUsers;
  }

  List get invitedUsers {
    return _invitedUsers;
  }

  void set userIsAuthenticated(bool userIsAuthenticated) {
    _userIsAuthenticated = userIsAuthenticated;
  }

  Map<String, FBUserVO> _friends;

  Map<String, FBUserVO> get friends {
    return _friends;
  }

  void set friends(Map<String, FBUserVO> friends) {
    _friends = friends;
  }

  List _friendsWithAdditionalInfo;

  List get friendsWithAdditionalInfo {
    return _friendsWithAdditionalInfo;
  }

  void set friendsWithAdditionalInfo(List fbUIDInfo) {
    _friendsWithAdditionalInfo = fbUIDInfo;
    _createAppUserFriendList(_friendsWithAdditionalInfo);
  }

  void _createAppUserFriendList(List collection) {
    _friendsWhoAreAppUsers = new Map<String, FBUserVO>();
    _friendsWhoAreAppUsersIndexed = [];
    for (num i = 0; i < collection.length; i++) {
      FBUserVO user = new FBUserVO(collection[i]);
      if (user.is_app_user) {
        _friendsWhoAreAppUsers[user.id] = user;
        _friendsWhoAreAppUsersIndexed.add(user.id);
      }
    }

  }

  Map<String, FBUserVO> _friendsWhoAreAppUsers;

  Map<String, FBUserVO> get friendsWhoAreAppUsers {
    return _friendsWhoAreAppUsers;
  }

  List _friendsWhoAreAppUsersIndexed;

  List get friendsWhoAreAppUsersIndexed {
    return _friendsWhoAreAppUsersIndexed;
  }

  String _permsToRequest;

  String get permsToRequest {
    return _permsToRequest;
  }

  void set permsToRequest(String permsToRequest) {
    _permsToRequest = permsToRequest;
  }

  String _authToken;

  String get accessToken {
    return _authToken;
  }

  void set accessToken(String authToken) {
    _authToken = authToken;
  }

  List _userPermissions = [];

  List get userPermissions {
    return _userPermissions;
  }

  void set userPermissions(List userPermissions) {
    _userPermissions = userPermissions;
  }

}
