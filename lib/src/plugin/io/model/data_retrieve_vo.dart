part of acanvas_framework.io;

/**
 * @author nilsdoehring
 */
class DataRetrieveVO implements IAcVO {
  int limit;
  int totalSize;
  String nextToken;

  /* optional */
  String id;

  DataRetrieveVO(this.limit, {this.nextToken: null, this.id: null}) {}

  Map toMap() {
    Map map = {"limit": limit, "nextToken": nextToken};

    return map;
  }
}
