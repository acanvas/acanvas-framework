part of acanvas_framework.ugc;

/**
 * @author nilsdoehring
 */
class UGCRatingVO implements IAcVO {
  int id;
  int rating;

  UGCRatingVO(this.id, [this.rating = -1]) {}
}
