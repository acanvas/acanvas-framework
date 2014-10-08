 part of stagexl_rockdot;

	 @retain
class FBPromptInviteBrowserCommand extends AbstractFBCommand {
		 VOFBInvite _vo;

		@override
		  dynamic execute([RockdotEvent event=null]) {
			super.execute(event);

			//http://developers.facebook.com/docs/reference/dialogs/requests/

			_vo = event.data;//VOFBInvite
			_vo.app_id = getProperty("project.facebook.appid");

			String reason = _vo.reason != null ? _vo.reason : RockdotConstants.VAR_REASON_VALUE_APPREQUEST_VIEW;

			//assemble data payload as query string.
			//supported pairs: item_id=X OR item_container_id=Y
			_vo.data = new Base64Codec().encodeString( _vo.data + "&reason=" + reason + "&uid=" + _fbModel.user.uid);

			Facebook.ui("apprequests", _vo, _dialogCallback, "iframe");
		}

		  void _dialogCallback(Map response) {
			//response.request (request object id)
			//response.to[<uid>]

			if(response is bool){
				dispatchCompleteEvent();
				return;
			}

			response["uid"] = _fbModel.session.uid;
			response["data"] = _vo.data;
			_fbModel.invitedUsers = response["to"];

			new RockdotEvent(UGCEvents.TRACK_INVITE, response, dispatchCompleteEvent).dispatch();

		}
	}

