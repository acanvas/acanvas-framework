part of rockdot_framework.ugc;

class UGCDataVO implements IRdVO {

  IRdDTO dao;
  String condition;
  String limit;

  UGCDataVO(this.dao, [this.condition = "", this.limit = ""]) {
  }
}
