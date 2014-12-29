part of stagexl_rockdot;

/**
 * @author Nils Doehring (nilsdoehring(gmail as at).com)
 */
class StateMessageVO implements IXLVO {
  static const int TYPE_INFO = 0;
  static const int TYPE_WARN = 1;
  static const int TYPE_ERROR = 2;
  static const int TYPE_WAITING = 3;
  static const int TYPE_LOADING = 4;
  
  String id;
  String message;
  int timeBox;
  int type;
  bool blurContent;
  
  int bgColor;
  int fontColor;

  StateMessageVO(this.id, this.message, this.timeBox, {this.type: -1, this.blurContent: false, this.bgColor : -1, this.fontColor: -1}) {
  }
}
