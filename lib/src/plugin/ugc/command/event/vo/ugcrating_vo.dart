part of stagexl_rockdot;

/**
 * @author nilsdoehring
 */
class UGCRatingVO implements IXLVO {
  int id;
  int rating;

  UGCRatingVO(this.id, [this.rating = -1]) {
  }
}
