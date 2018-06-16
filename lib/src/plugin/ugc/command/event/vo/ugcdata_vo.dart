part of acanvas_framework.ugc;

class UGCDataVO implements IAcVO {
  IAcDTO dao;
  String condition;
  String limit;

  UGCDataVO(this.dao, [this.condition = "", this.limit = ""]) {}
}
