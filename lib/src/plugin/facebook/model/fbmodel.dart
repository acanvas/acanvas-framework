 part of rockdot_dart;

	/**
	 * @author nilsdoehring
	 */
	 @retain
class FBModel {

		 FacebookSession _session;
		  FacebookSession get session {
			return _session;
		}
		  void set session(FacebookSession session) {
			_session = session;
		}


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
//			for (int i = 0; i < userAlbums.length; i++) {
//				userAlbums[i].access_token = session.accessToken;
//			}
			_userAlbums = userAlbums;
		}


		 List _userAlbumPhotos;
		  List get userAlbumPhotos {
			return _userAlbumPhotos;
		}
		  void set userAlbumPhotos(List userAlbumPhotos) {
			_userAlbumPhotos = userAlbumPhotos;
		}


		 bool _userIsAuthenticated;
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



		 Map _friends;
		  Map get friends {
			return _friends;
		}
		  void set friends(Map friends) {
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
			_friendsWhoAreAppUsers = {};
			_friendsWhoAreAppUsersIndexed = [];
			for (num i =0; i<collection.length;i++) {
				FBUserVO user = new FBUserVO(collection[i]);
				user.id = collection[i].uid;
	    		if (user.is_app_user) {
					_friendsWhoAreAppUsers[user.id] = user;
					_friendsWhoAreAppUsersIndexed.add(user.id);
				}
	    	}

		}


		 Map _friendsWhoAreAppUsers;
		  Map get friendsWhoAreAppUsers {
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

		 List _userPermissions = [];
		  List get userPermissions {
			return _userPermissions;
		}

		  void set userPermissions(List userPermissions) {
			_userPermissions = userPermissions;
		}

	}

