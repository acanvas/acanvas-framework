part of acanvas_framework.google;

class GoogleLoginCommand extends AbstractGoogleCommand {
  AcSignal _nextSignal;

  @override
  void execute([AcSignal event = null]) {
    super.execute(event);

    //var id = new ClientId(getProperty("project.google.oauth.clientid"), null);
    List<String> scopes;
    if (event != null && event.data != null) {
      if (event.data is String) {
        scopes = [event.data];
      } else if (event.data is List<String>) {
        scopes = event.data;
      } else if (event.data is GoogleLoginVO) {
        _nextSignal = event.data.nextSignal;
        scopes = event.data.scopes != null
            ? event.data.scopes
            : [getProperty("project.google.scope.plus")];
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

    showMessage(getProperty("message.google.login.waiting"),
        blur: true, type: StateMessageVO.TYPE_WAITING);
  }

  void _handleLoginError(UserConsentException ex) {
    _gModel.flow.close();
    hideMessage();
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
