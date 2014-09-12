part of rockdot_dart;

	/**
	 * @author nilsdoehring
	 */
	 class UGCUserExtendedVO extends RockdotVO {
		 String uid;
		 String hash;

		 String birthday_date;
		 String hometown_location;

		 String title;

		 String firstname;
		 String lastname;
		 String street;
		 String additional;
		 String city;
		 String county;
		 String country;

		 String email;
		 int email_confirmed = 0;

		 num score = 0;

		 int newsletter = 0;
		 int rules = 0;

		 String timestamp;
	 UGCUserExtendedVO([Object obj=null]) : super(obj){

		}

	}

