part of stagexl_rockdot;

class VOFBInvite {
  //http://developers.facebook.com/docs/reference/dialogs/requests/

  String action_type; //send, askfor, turn
  String object_id;
  String method;
  String message;
  String to;
  //f.ex. filters: [{name:'GROUP_1_NAME', user_ids:['USER_ID','USER_ID','USER_ID']},{name:'GROUP_2_NAME', user_ids: ['USER_ID','USER_ID','USER_ID']}]
  String filters;
  String app_id;
  String redirect_uri;
  String exclude_ids;
  String data;
  String title;
  int max_recipients;

  //unsure if still supported as of API v2.1
  String display;

  //Invite Source, will be put into 'data' String
  String reason;
  
  VOFBInvite([this.title, this.message, this.data, this.reason, this.to, this.max_recipients = 0]) {
  }

}
