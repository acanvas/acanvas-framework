part of rockdot_dart;
	 class UGCDataVO  extends RockdotVO{

		 RockdotVO dao;
		 String condition;
		 String limit;
		 @retain
    UGCDataVO(RockdotVO dao, [String condition="",String limit=""]) {
			this.condition = condition;
			this.limit = limit;
			this.dao = dao != null ? dao : new RockdotVO();
		}
	}

