part of stagexl_rockdot.facebook;

//https://developers.facebook.com/docs/games/requests/v2.1

//@retain
class FBPromptInviteBrowserCommand extends AbstractFBCommand {
  VOFBInvite _vo;

  @override
  void execute([XLSignal event = null]) {
    super.execute(event);
    
    if (notLoggedIn(event)) return;

    _vo = event.data;//VOFBInvite
    _vo.app_id = getProperty("project.facebook.appid");
    _vo.method = "apprequests";
    _vo.display = "iframe";

    String reason = _vo.reason != null ? _vo.reason : RockdotConstants.VAR_REASON_VALUE_APPREQUEST_VIEW;

    //assemble data payload as query string.
    //supported pairs: item_id=X OR item_container_id=Y
    _vo.data = html.window.btoa(_vo.data + "&reason=" + reason + "&uid=" + _fbModel.user.uid);

    
    Map inviteMap = {
       "method": _vo.method,
       "app_id": _vo.app_id,
       "title": _vo.title,
       "message": _vo.message,
       "data": _vo.data,             
       "display": _vo.display
    };
    
    if(_vo.to != null){
      inviteMap["to"] = _vo.to;
    }
    if(_vo.filters != null){
      inviteMap["filters"] = _vo.filters;
    }
    if(_vo.action_type != null){
      inviteMap["action_type"] = _vo.action_type;
    }
    if(_vo.object_id != null){
      inviteMap["object_id"] = _vo.object_id;
    }
    if(_vo.exclude_ids != null){
      inviteMap["exclude_ids"] = _vo.exclude_ids;
    }
    if(_vo.max_recipients > 0){
      inviteMap["max_recipients"] = _vo.max_recipients;
    }
    
    js.JsObject inviteConfig = new js.JsObject.jsify( inviteMap );
    
    _fbModel.FB.callMethod("ui", [inviteConfig, _handleResult]);
    
    showMessage(getProperty("message.facebook.invite.waiting"), blur:true, type: StateMessageVO.TYPE_WAITING);
  }

  void _handleResult(js.JsArray response) {
    hideMessage();
    
    if (containsError(response)) return;
   
    //response.request (request object id)
    //response.to[<uid>]

    if (response.length == 0) {
      dispatchCompleteEvent();
      return;
    }

    _fbModel.invitedUsers = response["to"].toList();
    
    Map dto = {
      'uid': _fbModel.user.uid,
      'request': response["request"],
      'data': _vo.data,
      'to_ids': _fbModel.invitedUsers
    };

    new XLSignal(UGCEvents.TRACK_INVITE, dto, dispatchCompleteEvent).dispatch();

  }
}
