part of stagexl_rockdot.ugc;
class UGCDataVO implements IXLVO {

  IXLDTO dao;
  String condition;
  String limit;

  UGCDataVO(this.dao, [this.condition = "", this.limit = ""]) {
  }
}
