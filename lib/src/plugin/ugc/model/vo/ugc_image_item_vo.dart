part of stagexl_rockdot;

@retain
class UGCImageItemVO extends RockdotVO {
    int id;
    int w;
    int h;
    String url_big;
    String url_thumb;
    String timestamp;
    
    UGCImageItemVO([dynamic object = null]) : super(object);
}