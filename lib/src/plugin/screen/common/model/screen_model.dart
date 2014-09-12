part of rockdot_dart;








/**
	 * @author Nils Doehring (nilsdoehring(gmail as at).com)
	 */

@retain
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
