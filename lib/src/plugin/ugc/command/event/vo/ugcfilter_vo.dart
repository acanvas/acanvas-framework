part of stagexl_rockdot;

	/**
	 * @author nilsdoehring
	 */
@retain
class UGCFilterVO extends RockdotVO{

		 static const String CONDITION_ALL = "CONDITION_ALL";
		 static const String CONDITION_ME = "CONDITION_ME";
		 static const String CONDITION_FRIENDS = "CONDITION_FRIENDS";
		 static const String CONDITION_UID = "CONDITION_UID";
		 static const String CONDITION_UGC_ID = "CONDITION_UGC_ID";
		
		 static const String ORDER_DATE_DESC = "timestamp DESC";
		 static const String ORDER_LIKES_DESC = "like_count DESC";

		 String condition;
		 String order;
		 int limit;
		 int limitindex;
		
		//ONE (and only one) of these needs to be set
		 List creator_uids; //CONDITION_FRIENDS
		 String creator_uid; //CONDITION_ME, CONDITION_UID
		 int item_id; //CONDITION_UGC_ID
	 
		 UGCFilterVO(String condition,String order,int limit) {
			this.condition = condition;
			this.order = order;
			this.limit = limit;
			limitindex = 0;
		}
	}

