 part of stagexl_rockdot;

	 @retain
class FBLogoutBrowserCommand extends AbstractFBCommand {
		@override
		  dynamic execute([RockdotEvent event=null]) {
			super.execute(event);

			if (RockdotConstants.LOCAL) {
				this.log.debug("Facebook Not Supported here.");

				RockdotConstants.getStage().juggler.delayCall(dispatchCompleteEvent, .05);

			} else {
				Facebook.logout(_handleComplete);
			}
		}

		  void _handleComplete(Map response,[Map fail=null]) {
			if (response != null) {
				_fbModel.userIsAuthenticated = false;
				_fbModel.session = null;
				_fbModel.user = null;
				_fbModel.userAlbumPhotos = [];
				_fbModel.userAlbums = [];
			}
			dispatchCompleteEvent(response);
		}
	}

