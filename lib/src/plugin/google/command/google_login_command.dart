part of stagexl_rockdot;

@retain
class GoogleLoginCommand extends AbstractGoogleCommand {

  @override
  void execute([XLSignal event = null]) {
    super.execute(event);

    var id = new ClientId(getProperty("project.google.oauth.clientid"), null);
    List scopes;
    if (event.data != null) {
      if (event.data is String) {
        scopes = [event.data];
      } else if (event.data is List) {
        scopes = event.data;
      }
    } else {
      scopes = [];
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
        dispatchCompleteEvent();
        return;
      }
    }


// Initialize the browser oauth2 flow functionality.
    createImplicitBrowserFlow(id, scopes).then((BrowserOAuth2Flow flow) {
      flow.clientViaUserConsent().then((AutoRefreshingAuthClient client) {
        _handleLogin(client);
        flow.close();
      }).catchError(dispatchErrorEvent);
    });
    
    showMessage("message.google.login.waiting", blur:true);
  }

  void _handleLogin(AutoRefreshingAuthClient client) {
    hideMessage();
    
    _gModel.client = client;
    _gModel.userScopes = client.credentials.scopes;
    _gModel.accessToken = client.credentials.accessToken.data;
    _gModel.userIsAuthenticated;
    dispatchCompleteEvent();
  }
}
