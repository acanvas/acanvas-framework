part of stagexl_rockdot;

	/**
	 * @author nilsdoehring
	 */
	 class UGCItemContainerRoleVO extends RockdotVO {
		 int id;
		 int container_id;
		 String uid;
		 int role; //0:owner, 1:participant, 2:follower
		 String timestamp;
	 UGCItemContainerRoleVO([dynamic obj=null]):super(obj) {

		}
	}

