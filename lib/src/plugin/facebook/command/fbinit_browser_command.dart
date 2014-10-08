 part of stagexl_rockdot;

	 @retain
class FBInitBrowserCommand extends AbstractFBCommand {

		@override
		  dynamic execute([RockdotEvent event=null]) {
			super.execute(event);

			if(RockdotConstants.LOCAL) {
				this.log.debug("Facebook Not Supported here.");
				dispatchCompleteEvent();
			} else {
				Facebook._init(getProperty("project.facebook.appid"), _handleComplete);
			}
		}

		  void _handleComplete(Map response,[Map fail=null]) {
			if (response != null && response["accessToken"]!= null) {
				_fbModel.userIsAuthenticated = true;
				_fbModel.session = response as FacebookSession;

				new RockdotEvent(FBEvents.USER_GETINFO_PERMISSIONS, null, _onPermissions).dispatch();

				return;
			}
			if( fail != null){
			  this.log.debug("FB Init did not produce a valid access token: {1} (code: {2}, type: {3})", [fail["error"].message, fail["error"].code, fail["error"].type]);
				dispatchErrorEvent(fail["error"]);
			}
			else{
			  this.log.debug("FB Init did not produce any result.");
				dispatchCompleteEvent();
			}
		}

		  void _onPermissions(List perms) {
			dispatchCompleteEvent(_fbModel.session);
		}
	}

