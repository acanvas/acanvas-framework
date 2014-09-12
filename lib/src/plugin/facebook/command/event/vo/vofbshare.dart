 part of rockdot_dart;

	 class VOFBShare
	{

		 String message;
		 String title;
		 String image;
		 String receiverUID;
		 String contentlink;
		 String actionText;
		 String actionLink;
	 VOFBShare([String title="", String message="", String image="", String contentlink="", String actionText="", String actionLink="" ]) {
			this.image = image;
			this.title = title;
			this.message = message;
			this.contentlink = contentlink;
			this.actionText = actionText;
			this.actionLink = actionLink == "" ? contentlink : actionLink;
		}

	}

