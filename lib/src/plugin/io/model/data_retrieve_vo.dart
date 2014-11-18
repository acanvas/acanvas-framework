part of stagexl_rockdot;

/**
 * @author nilsdoehring
 */
class DataRetrieveVO implements IXLVO {

  int limit;
  int totalSize;
  String nextToken;

  /* optional */
  String id;

  DataRetrieveVO(this.limit, {this.nextToken: null, this.id: null}) {
  }
  
  Map toMap(){
    Map map = {
      "limit": limit,         
      "nextToken": nextToken         
    };
    
    return map;
  }
  
}
