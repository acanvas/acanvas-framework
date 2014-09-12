part of rockdot_dart;

	/**
	 * @author nilsdoehring
	 */
	 class UGCEvents {
		
		//expects nothing, returns nothing
		 static const String INIT		 				= "UGCEvents.INIT";
		 static const String TEST		 				= "UGCEvents.TEST";
		
		//expects DAOUGCCRUD, returns OperationEvent with result = id of inserted row
		 static const String CREATE_ITEM 				= "UGCEvents.CREATE_ITEM";

		//expects DAOUGCCRUD, returns OperationEvent with result = List<UGCItemDAO>
		 static const String READ_ITEM 				= "UGCEvents.READ_ITEMS";
		

		//expects DAOUGCCRUD, returns OperationEvent with result = id of inserted row
		 static const String CREATE_ITEM_CONTAINER 				= "UGCEvents.CREATE_ITEM_CONTAINER";

		//expects DAOUGCCRUD, returns OperationEvent with result = List<UGCItemDAO>
		 static const String READ_ITEM_CONTAINER 				= "UGCEvents.READ_ITEM_CONTAINER";
		 static const String READ_ITEM_CONTAINERS_UID 			= "UGCEvents.READ_ITEM_CONTAINERS_UID";
		
		
		//expects nothing, uses _ugcModel.userDAO or creates new User (from FB data!), returns UserDAO
		 static const String USER_REGISTER 				= "UGCEvents.USER_REGISTER";

		//expects nothing, uses _ugcModel.userDAO or creates new User (from FB data!), returns UserDAO, sets _ugcModel.userDAO
		 static const String USER_REGISTER_EXTENDED 	= "UGCEvents.USER_REGISTER_EXTENDED";

		//expects nothing, uses .properties and _ugcModel.userSweepstakeDAO.email
		 static const String USER_MAIL_SEND 			= "UGCEvents.USER_MAIL_SEND";

		//expects DAOUGCFilter, supports following DAOUGCFilter.conditions :
		//DAOUGCFilter.CONDITION_FRIENDS: filter by facebook friends that also participated with an upload
		//DAOUGCFilter.CONDITION_ME: filter by my own uploads
		//DAOUGCFilter.CONDITION_UGC_ID: filter by an Item's ID
		//DAOUGCFilter.CONDITION_ALL: no filter (you can still arrange by date or likes)
		//DAOUGCFilter.CONDITION_UID: filter by a uid
		 static const String ITEMS_FILTER 				= "UGCEvents.ITEMS_FILTER";

		//DAOUGCFilter, sets/returns _ugcModel.currentItemDAO.likers (List<UGCUserDAO>)
		 static const String ITEM_LIKERS_GET 			= "UGCEvents.ITEM_LIKERS_GET";
		
		//expects (int.parse(item id)), uses _ugcModel.userDAO.uid, returns nothing
		 static const String ITEM_LIKE 					= "UGCEvents.ITEM_LIKE";
		
		//expects (int.parse(item id)), uses _ugcModel.userDAO.uid, returns nothing
		 static const String ITEM_UNLIKE 				= "UGCEvents.ITEM_UNLIKE";
		
		//expects DAOUGCItem, using DAOUGCItem.di, DAOUGCItem.rating, _ugcModel.userDAO.uid, returns nothing
		 static const String ITEM_RATE 					= "UGCEvents.ITEM_RATE";

		//expects DAOUGCItem, using DAOUGCItem.id, DAOUGCItem.rating, _ugcModel.userDAO.uid, returns nothing
		 static const String ITEM_COMPLAIN 				= "UGCEvents.ITEM_COMPLAIN";

		//expects nothing, uses _ugcModel.currentItemDAO.id, returns nothing
		 static const String ITEM_DELETE = "UGCEvents.ITEM_DELETE";
		
		//UGCFriendsReadCommand, uses _modelFB.friendsWhoAreAppUsers, sets/returns _ugcModel.friendsWithUGCItems (List<UGCUserDAO>)
		 static const String ITEMS_FRIENDS_GET = "UGCEvents.ITEMS_FRIENDS_GET";
		
		//{uid:"", request_id:"", data:"", to:ids:""}
		 static const String TRACK_INVITE = "UGCEvents.TRACK_INVITE";

		//TASK: Get Category List
		 static const String TASK_GET_CATEGORIES = "UGCEvents.TASK_GET_CATEGORIES";

		//TASK: Get Tasks by Category
		 static const String TASK_GET_TASK_BY_CATEGORY = "UGCEvents.TASK_GET_TASK_BY_CATEGORY";
	
		//TASK: Assign Task to Itemcontainer
		 static const String TASK_ASSIGN_TO_CONTAINER = "UGCEvents.TASK_ASSIGN_TO_CONTAINER";
		 static const String USER_HAS_EXTENDED = "UGCEvents.USER_READ_EXTENDED";
		 static const String USER_HAS_EXTENDED_TODAY = "UGCEvents.USER_HAS_EXTENDED_TODAY";
		
	}

