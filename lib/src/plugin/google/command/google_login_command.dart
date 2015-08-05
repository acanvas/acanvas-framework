part of stagexl_rockdot.google;

//@retain
class GoogleLoginCommand extends AbstractGoogleCommand {
  XLSignal _nextSignal;

  @override
  void execute([XLSignal event = null]) {
    super.execute(event);

    var id = new ClientId(getProperty("project.google.oauth.clientid"), null);
    List scopes;
    if (event != null && event.data != null) {
      if (event.data is String) {
        scopes = [event.data];
      } else if (event.data is List) {
        scopes = event.data;
      } else if (event.data is GoogleLoginVO) {
        _nextSignal = event.data.nextSignal;
        scopes = event.data.scopes != null ? event.data.scopes : [getProperty("project.google.scope.plus")];
      }
    } else {
      scopes = [getProperty("project.google.scope.plus")];
    }

    if (_gModel.userIsAuthenticated) {

      int count = 0;
      scopes.forEach((String s) {
        _gModel.userScopes.forEach((String us) {
          if (s == us) {
            count++;
          }
        });
      });

      if (count == scopes.length) {
        if (_nextSignal != null) {
          _nextSignal.dispatch();
        }
        dispatchCompleteEvent();
        return;
      }
    }


    // Initialize the browser oauth2 flow functionality.
    _gModel.flow.clientViaUserConsent().then((AutoRefreshingAuthClient client) {
      _handleLogin(client);
    }, onError: _handleLoginError);

    showMessage(getProperty("message.google.login.waiting"), blur: true, type: StateMessageVO.TYPE_WAITING);
  }

  void _handleLoginError(UserConsentException ex) {
    dispatchErrorEvent(ex.message);
  }

  void _handleLogin(AutoRefreshingAuthClient client) {
    hideMessage();

    _gModel.flow.close();
    _gModel.client = client;
    _gModel.userScopes = client.credentials.scopes;
    _gModel.accessToken = client.credentials.accessToken.data;
    _gModel.userIsAuthenticated = true;

    dispatchCompleteEvent();

    if (_nextSignal != null) {
      _nextSignal.dispatch();
    }
  }
}
