 part of stagexl_rockdot;

	 class VOFBInvite
	{
		//http://developers.facebook.com/docs/reference/dialogs/requests/

		 String app_id;
		 String method;
		 String display;
		 String redirect_uri;
		 String message;
		 String to;
		 String filters;
		 String exclude_ids;
		 String data;
		 String title;
		 int max_recipients;

		//Invite Source, will be put into 'data' String
		 String reason;
	 VOFBInvite([String title="", String message="", String data="", String reason="", String to="", int max_recipients=0]) {
			this.title = title;
			this.data = data;
			this.message = message;
			this.reason = reason;
			this.to = to;

			if(max_recipients>0){
				this.max_recipients = max_recipients;
			}
		}

	}

