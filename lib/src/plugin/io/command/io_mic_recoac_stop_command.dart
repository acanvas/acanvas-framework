part of acanvas_framework.io;

/**
 * Code taken from:
 * http://stackoverflow.com/questions/21348509/how-to-save-microphone-audio-input
 * https://github.com/mattdiamond/Recorderjs/blob/master/src/recorder.js
 *
 */
class IOMicRecordStopCommand extends AbstractIOCommand {
  static const bool MINIMIZE = true;
  static const int MINIMIZE_SAMPLE_RATE = 16000;

  @override
  void execute([AcSignal event = null]) {
    super.execute(event);

    // stop recording
    ioModel.mic_recording = false;

    // flatten left channel
    Float32List leftBuffer =
        mergeBuffers(ioModel.mic_leftchannel, ioModel.mic_recordingLength);

    if (MINIMIZE) {
      // downsample to 16KHz, only left channel (mono)
      _downSample(MINIMIZE_SAMPLE_RATE, _ioModel.mic_sampleRate, leftBuffer)
          .then((AudioBuffer buffer) {
        ByteData result =
            _encodeWAV(1, MINIMIZE_SAMPLE_RATE, buffer.getChannelData(0));
        _finalize(result);
      });
    } else {
      // flatten right channel, too
      Float32List rightBuffer =
          mergeBuffers(ioModel.mic_rightchannel, ioModel.mic_recordingLength);
      // we interleave both channels together
      Float32List interleaved = interleave(leftBuffer, rightBuffer);
      ByteData result = _encodeWAV(2, _ioModel.mic_sampleRate, interleaved);
      _finalize(result);
    }
  }

  /**
   * Taken from:
   * http://stackoverflow.com/questions/27598270/resample-audio-buffer-from-44100-to-16000
   */
  Future<AudioBuffer> _downSample(
      int targetSampleRate, int sourceSampleRate, Float32List sampleBuffer) {
    OfflineAudioContext o =
        new OfflineAudioContext(1, sampleBuffer.length, targetSampleRate);
    AudioBuffer b = o.createBuffer(1, sampleBuffer.length, sourceSampleRate);
    Float32List buf = b.getChannelData(0);
    buf.setAll(0, sampleBuffer);

    /* Reset to the beginning. */
    AudioBufferSourceNode source = o.createBufferSource();
    source.buffer = b;
    source.connectNode(o.destination);
    source.start(0);

    /* Start rendering as fast as the machine can. */
    return o.startRendering();
  }

  ByteData _encodeWAV(
      int numChannels, int sampleRate, Float32List interleaved) {
    // we create our wav file
    ByteBuffer buffer = new Uint8List(44 + interleaved.length * 2).buffer;
    ByteData view = new ByteData.view(buffer);

    // RIFF chunk descriptor
    writeUTFBytes(view, 0, 'RIFF');
    view.setUint32(4, 44 + interleaved.length * 2, Endian.little);
    writeUTFBytes(view, 8, 'WAVE');

    // FMT sub-chunk
    writeUTFBytes(view, 12, 'fmt ');
    view.setUint32(16, 16, Endian.little);
    view.setUint16(20, 1, Endian.little);

    // mono (1 channel) or stereo (2 channels)
    view.setUint16(22, numChannels, Endian.little);
    view.setUint32(24, sampleRate, Endian.little);
    view.setUint32(28, sampleRate * 4, Endian.little);
    view.setUint16(32, numChannels * 2, Endian.little);
    view.setUint16(34, 16, Endian.little);

    // data sub-chunk
    writeUTFBytes(view, 36, 'data');
    view.setUint32(40, interleaved.length * 2, Endian.little);

    // write the PCM samples
    int lng = interleaved.length;
    int offset = 44;
    //int volume = 1;
    for (int i = 0; i < lng; i++) {
      num s = math.max(-1, math.min(1, interleaved[i]));
      view.setInt16(
          offset, (s < 0 ? s * 0x8000 : s * 0x7FFF).truncate(), Endian.little);
      // old: view.setInt16(offset, (interleaved[i] * (0x7FFF * volume)).truncate(), Endian.little);
      offset += 2;
    }

    return view;
  }

  void _finalize(ByteData result) {
    // our final binary blob
    ioModel.mic_recorded_blob = new html.Blob([result], 'audio/wav');

    // let's save it locally
    String url = html.Url.createObjectUrlFromBlob(ioModel.mic_recorded_blob);
    html.AnchorElement link = new html.AnchorElement()
      ..href = url
      ..text = 'download'
      ..download = 'output.wav';
    html.document.body.append(link);

    html.Event event =
        new html.Event("click", canBubble: true, cancelable: true);
    link.dispatchEvent(event);

    dispatchCompleteEvent(ioModel.mic_recorded_blob);
  }

  /*
        Helpers
   */

  void writeUTFBytes(ByteData view, offset, String string) {
    int lng = string.length;
    for (int i = 0; i < lng; i++) {
      view.setUint8(offset + i, string.codeUnitAt(i));
    }
  }

  Float32List interleave(Float32List leftChannel, Float32List rightChannel) {
    int length = leftChannel.length + rightChannel.length;
    Float32List result = new Float32List(length);

    int inputIndex = 0;

    for (int index = 0; index < length;) {
      result[index++] = leftChannel[inputIndex];
      result[index++] = rightChannel[inputIndex];
      inputIndex++;
    }
    return result;
  }

  List mergeBuffers(List<Float32List> channelBuffer, int recordingLength) {
    List result = new List();
    //int offset = 0;
    int lng = channelBuffer.length;
    for (int i = 0; i < lng; i++) {
      Float32List buffer = channelBuffer[i];
      result.addAll(buffer); //was: setRange
      //offset += buffer.length;
    }
    return result;
  }

  Float32List mergeBuffersTest(
      List<Float32List> channelBuffer, int recordingLength) {
    Float32List result = new Float32List(recordingLength);
    int offset = 0;
    int lng = channelBuffer.length;
    for (int i = 0; i < lng; i++) {
      Float32List buffer = channelBuffer[i];
      result.setAll(offset, buffer); //was: setRange
      offset += buffer.length;
    }
    return result;
  }
}
