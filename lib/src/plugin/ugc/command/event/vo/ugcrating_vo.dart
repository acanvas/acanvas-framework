part of rockdot_framework.ugc;

/**
 * @author nilsdoehring
 */
class UGCRatingVO implements IRdVO {
  int id;
  int rating;

  UGCRatingVO(this.id, [this.rating = -1]) {}
}
