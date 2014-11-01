part of stagexl_rockdot;

/**
 * @author Nils Doehring (nilsdoehring(gmail as at).com)
 */
class StateChangeVO implements IXLVO {
  StateVO oldVO;
  StateVO newVO;

  StateChangeVO(this.oldVO, this.newVO) {
  }
}
