part of acanvas_framework.state;

/**
 * @author Nils Doehring (nilsdoehring(gmail as at).com)
 */
class StateChangeVO implements IAcVO {
  StateVO oldVO;
  StateVO newVO;

  StateChangeVO(this.oldVO, this.newVO) {}
}
