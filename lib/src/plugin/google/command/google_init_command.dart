part of rockdot_framework.google;

//@retain
class GoogleInitCommand extends AbstractGoogleCommand {
  @override
  void execute([RdSignal event = null]) {
    super.execute(event);

    var id = new ClientId(getProperty(getProperty("project.google.oauth.clientid")), null);
    List<String> scopes;
    if (event.data != null) {
      if (event.data is String) {
        scopes = <String>[event.data];
      } else if (event.data is List) {
        scopes = event.data;
      }
    } else {
      scopes = [getProperty("project.google.scope.plus")];
    }

// Initialize the browser oauth2 flow functionality.
    createImplicitBrowserFlow(id, scopes).then((BrowserOAuth2Flow flow) {
      _gModel.flow = flow;
      flow.clientViaUserConsent(immediate: true).then((AutoRefreshingAuthClient client) {
        _handleLogin(client);
        flow.close();
      }, onError: (e) {
        _handleInitError(e);
      });
    }).catchError((e) {
      log.error("Error while creating ImplicitBrowserFlow: ${e}");
      dispatchCompleteEvent();
    });
  }

  void _handleInitError(UserConsentException ex) {
    //dispatchErrorEvent(ex.message);
    log.error(ex.message);
    dispatchCompleteEvent();
  }

  void _handleLogin(AutoRefreshingAuthClient client) {
    _gModel.client = client;
    _gModel.userScopes = client.credentials.scopes;
    _gModel.accessToken = client.credentials.accessToken.data;
    _gModel.userIsAuthenticated = true;
    dispatchCompleteEvent();
  }
}
