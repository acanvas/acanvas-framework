 part of stagexl_rockdot;

	/**
	 * @author nilsdoehring
	 */
	 class FBEvents{

		 static const String INIT 						= "CommandFB.INIT";
		 static const String TEST 						= "CommandFB.TEST";

		//expects VOFBShare, returns nothing
		 static const String PROMPT_SHARE 				= "CommandFB.PROMPT_SHARE";

		//expects VOFBInvite, returns nothing
		 static const String PROMPT_INVITE 				= "CommandFB.PROMPT_INVITE";

		//expects perms (optional), sets _fbModel.session
		 static const String USER_LOGIN 				= "CommandFB.USER_LOGIN";
		 static const String USER_LOGOUT 				= "CommandFB.USER_LOGOUT";

		/* The following Events require a valid _fbModel.session */

		//expects nothing, sets _fbModel.user
		 static const String USER_GETINFO 				= "CommandFB.USER_GETINFO";
		 static const String USER_GETINFO_PERMISSIONS 	= "CommandFB.USER_GETINFO_PERMISSIONS";

		//expects nothing, sets/returns _fbModel.friends (List<FBUserDataVO>)
		 static const String FRIENDS_GET 				= "CommandFB.FRIENDS_GET";

		//expects nothing, sets/returns _fbModel.friendsWithAdditionalInfo  (List<FBUserDataVO>)
		 static const String FRIENDS_GETINFO 			= "CommandFB.FRIENDS_GETINFO";

		//expects nothing, it's just a test
		 static const String EVENT_CREATE 				= "CommandFB.EVENT_CREATE";

		//expects nothing, sets/returns _fbModel.userAlbums  (List<FBAlbumDataVO>)
		 static const String ALBUMS_GET 				= "CommandFB.ALBUMS_GET";

		//expects String (album id), sets/returns _fbModel.userAlbumPhotos (List<FBPhotoDataVO>)
		 static const String PHOTOS_GET 				= "CommandFB.PHOTOS_GET";

		//expects VOFBPhotoUpload, returns nothing
		 static const String PHOTO_UPLOAD = "CommandFB.PHOTO_UPLOAD";
	}

