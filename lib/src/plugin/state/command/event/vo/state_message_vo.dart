part of stagexl_rockdot;

/**
 * @author Nils Doehring (nilsdoehring(gmail as at).com)
 */
class StateMessageVO implements IXLVO {
  static const int TYPE_INFO = 0;
  static const int TYPE_WARN = 1;
  static const int TYPE_ERROR = 2;
  
  String id;
  String message;
  int timeBox;
  int level;
  bool blurContent;

  StateMessageVO(this.id, this.message, this.timeBox, this.level, this.blurContent) {
  }
}
