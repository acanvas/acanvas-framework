part of rockdot_framework.google;

/**
 * @author nilsdoehring
 */
class GoogleModel {
  BrowserOAuth2Flow _flow;

  BrowserOAuth2Flow get flow {
    return _flow;
  }

  void set flow(BrowserOAuth2Flow flow) {
    _flow = flow;
  }

  Person _user;

  Person get user {
    return _user;
  }

  void set user(Person user) {
    _user = user;
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

  List<String> _userScopes = [];

  List<String> get userScopes {
    return _userScopes;
  }

  void set userScopes(List<String> userScopes) {
    _userScopes = userScopes;
  }
}
