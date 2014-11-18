part of stagexl_rockdot;

/**
	 * @author nilsdoehring
	 */
class GoogleModel {

  Person _user;
  Person get user {
    return _user;
  }
  void set user(Person user) {
    _user = user;
  }

  MomentsFeed _moments;
  MomentsFeed get moments {
    return _moments;
  }
  void set moments(MomentsFeed moments) {
    _moments = moments;
  }

  PeopleFeed _circles;
  PeopleFeed get circles {
    return _circles;
  }
  void set circles(PeopleFeed circles) {
    _circles = circles;
  }

  bool _userIsAuthenticated = false;
  bool get userIsAuthenticated {
    return _userIsAuthenticated;
  }
  void set userIsAuthenticated(bool userIsAuthenticated) {
    _userIsAuthenticated = userIsAuthenticated;
  }

  String _scopesToRequest;
  String get scopesToRequest {
    return _scopesToRequest;
  }
  void set scopesToRequest(String scopesToRequest) {
    _scopesToRequest = scopesToRequest;
  }

  String _authToken;
  String get accessToken {
    return _authToken;
  }
  void set accessToken(String authToken) {
    _authToken = authToken;
  }

  AutoRefreshingAuthClient _client;
  AutoRefreshingAuthClient get client {
    return _client;
  }
  void set client(AutoRefreshingAuthClient client) {
    _client = client;
  }

  List _userScopes = [];
  List get userScopes {
    return _userScopes;
  }

  void set userScopes(List userScopes) {
    _userScopes = userScopes;
  }

}
