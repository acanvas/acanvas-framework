part of stagexl_rockdot.ugc;

/**
 * @author nilsdoehring
 */
class UGCRatingVO implements IXLVO {
  int id;
  int rating;

  UGCRatingVO(this.id, [this.rating = -1]) {
  }
}
