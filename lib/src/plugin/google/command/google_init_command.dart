part of stagexl_rockdot;

@retain
class GoogleInitCommand extends AbstractGoogleCommand {

  @override
  void execute([XLSignal event = null]) {
    super.execute(event);

    var id = new ClientId(getProperty(getProperty("project.google.oauth.clientid")), null);
    List scopes;
    if (event.data != null) {
      if (event.data is String) {
        scopes = [event.data];
      } else if (event.data is List) {
        scopes = event.data;
      } 
    }
    else {
      scopes = [];
    }
    

// Initialize the browser oauth2 flow functionality.
    createImplicitBrowserFlow(id, scopes).then((BrowserOAuth2Flow flow) {
      flow.clientViaUserConsent(immediate: true)
        .then((AutoRefreshingAuthClient client) {
          _handleLogin(client);
          flow.close();
        }, onError: dispatchErrorEvent);
    });
  }

  void _handleLogin(AutoRefreshingAuthClient client) {
    _gModel.client = client;
    _gModel.userScopes = client.credentials.scopes;
    _gModel.accessToken = client.credentials.accessToken.data;
    _gModel.userIsAuthenticated = true;
    dispatchCompleteEvent();
  }
}
