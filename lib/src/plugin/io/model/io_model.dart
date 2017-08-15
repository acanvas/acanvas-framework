part of rockdot_framework.io;

/**
 * @author nilsdoehring
 */
class IOModel {
  static const String HOLDER_ELEMENT = "upload-holder";
  static const String FILE_ELEMENT = "file";

  bool mic_recording = false;

  List<Float32List> mic_leftchannel = [];
  List<Float32List> mic_rightchannel = [];

  int mic_recordingLength = 0;

  html.Blob mic_recorded_blob;

  num mic_sampleRate;

}
