part of stagexl_rockdot;

class UGCVideoItemVO extends RockdotVO {
  int id;
  int w;
  int h;
  int length;

  String url_big;
  String url_thumb;
  String timestamp;
  
  UGCVideoItemVO([dynamic object = null]) : super(object);
}
