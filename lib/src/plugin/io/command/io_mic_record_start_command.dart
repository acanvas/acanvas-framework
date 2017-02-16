part of rockdot_framework.io;

/**
 * Code taken from: http://stackoverflow.com/questions/21348509/how-to-save-microphone-audio-input
 */

class IOMicRecordStartCommand extends AbstractIOCommand {
  StreamSubscription<AudioProcessingEvent> _stream;

  @override
  void execute([RdSignal event = null]) {
    super.execute(event);

    /* reset values */
    ioModel.mic_recording = true;
    ioModel.mic_leftchannel.clear();
    ioModel.mic_rightchannel.clear();
    ioModel.mic_recordingLength = 0;

    html.window.navigator.getUserMedia(audio: true).then((html.MediaStream stream) {
      AudioContext context = new AudioContext();
      ioModel.mic_sampleRate = context.sampleRate;
      print(ioModel.mic_sampleRate);
      GainNode volume = context.createGain();
      MediaStreamAudioSourceNode audioInput = context.createMediaStreamSource(stream);
      audioInput.connectNode(volume);

      int bufferSize = 2048;
      ScriptProcessorNode recorder = context.createScriptProcessor(bufferSize, 2, 2);

      _stream = recorder.onAudioProcess.listen((AudioProcessingEvent e) {
        if (!ioModel.mic_recording) {
          /* audioInput.disconnect();
          context.close();
          recorder.disconnect(); */
          _cancelStream();
          dispatchCompleteEvent();
          return;
        }

        log.debug('recording');

        // process Data
        ioModel.mic_leftchannel.add(new Float32List.fromList(e.inputBuffer.getChannelData(0)));
        ioModel.mic_rightchannel.add(new Float32List.fromList(e.inputBuffer.getChannelData(1)));
        ioModel.mic_recordingLength += bufferSize;
      });

      volume.connectNode(recorder);
      recorder.connectNode(context.destination);
    });
  }

  void _cancelStream() {
    _stream.cancel();
  }
}
