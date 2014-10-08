part of stagexl_rockdot;

	/**
	 * @author nilsdoehring
	 */
@retain
class UGCRatingVO extends RockdotVO {
		 int id;
		 int rating;
	 UGCRatingVO(int id,[int rating=-1]) {
			this.id = id;
			this.rating = rating;
		}
	}

