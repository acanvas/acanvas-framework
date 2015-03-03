part of stagexl_rockdot.screen;

/**
 * @author Nils Doehring (nilsdoehring(gmail as at).com)
 */

class ScreenModel {

  num _lastResizeTime = 0;
  num get lastResizeTime {
    return _lastResizeTime;
  }
  void set lastResizeTime(num lastResizeTime) {
    _lastResizeTime = lastResizeTime;
  }

  ScreenModel() {
  }

}
