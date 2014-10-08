 part of stagexl_rockdot;

	 @retain
class FBLoginBrowserCommand extends AbstractFBCommand {

		@override
		  dynamic execute([RockdotEvent event=null]) {
			super.execute(event);

			if(RockdotConstants.LOCAL) {
				this.log.debug("Facebook Not Supported here.");
				dispatchErrorEvent("Facebook Not Supported here.");
			} else {
				if(_fbModel.session != null && _fbModel.userIsAuthenticated && event.data == "" ) {
					dispatchCompleteEvent(_fbModel.session);
				} else {
					Facebook.login(_handleLogin, {"perms": event.data });
				}
			}
		}

		  void _handleLogin(Map response,[Map fail=null]) {
			if (response != null && response["accessToken"] != null) {
				_fbModel.userIsAuthenticated = true;
				_fbModel.session = response as FacebookSession;
				dispatchCompleteEvent(response);
			} else if (fail != null){
			  this.log.error("Not Connected: " + fail.toString());
				dispatchErrorEvent(fail);
			}
			else{
			  this.log.debug("stupid empty callback");
			}
		}
	}

