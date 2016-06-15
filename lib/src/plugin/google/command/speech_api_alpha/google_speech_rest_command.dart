part of rockdot_framework.google;

class GoogleSpeechRestCommand extends AbstractGoogleCommand {

  String API_KEY = "";

  @override
  void execute([RdSignal event = null]) {
    super.execute(event);

    //if (notLoggedIn(event)) return;


    html.Blob recording;
    if (event.data != null && event.data is html.Blob) {
      recording = event.data;
    }
    else{
      dispatchErrorEvent("Please provide a blob in event data payload");
      return;
    }

    html.FileReader fileReader = new html.FileReader();
    fileReader.readAsDataUrl(recording);
    fileReader.onLoadEnd.listen((progress) {
      /* dirty */
      String base64data = fileReader.result;
      base64data = base64data.replaceFirst("data:audio/wav;base64,", "");

      Map map = new Map();
      map["initialRequest"] = new Map();
      map["initialRequest"]["encoding"] = "LINEAR16"; //TODO see if we can get flac.js to work
      //map["initialRequest"]["language_code"] = "de-DE";
      map["initialRequest"]["sampleRate"] = 16000; //TODO get samplerate from IOModel
      map["audioRequest"] = new Map();
      map["audioRequest"]["content"] = base64data;


      String jsonData = JSON.encode(map);
      _sendData(jsonData);
    });

  }

  void _sendData(String json) {
    html.HttpRequest request = new html.HttpRequest(); // create a new XHR

    // add an event handler that is called when the request finishes
    request.onReadyStateChange.listen((_) {
      if (request.readyState == html.HttpRequest.DONE ) {
        if (request.status == 200 || request.status == 0) {
          // data saved OK.
          print(request.responseText); // output the response from the server

          // TODO decode json
          dispatchCompleteEvent(request.responseText);
        }
        else {
          print(request.responseText);
          dispatchErrorEvent(request.responseText);
        }
      }
    });

    // POST the data to the server
    String url = "https://speech.googleapis.com/v1/speech:recognize?key=$API_KEY";
    request.open("POST", url, async: true);
    request.send(json); // perform the async POST
  }

}
