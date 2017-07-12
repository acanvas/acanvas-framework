part of rockdot_framework.io;

class IOFileSelectCreateCommand extends RdCommand {
  @override
  void execute([RdSignal event = null]) {
    super.execute(event);

    html.InputElement div = html.querySelector(IOModel.HOLDER_ELEMENT);
    if(div == null){
      div = new html.InputElement();
      div.id = IOModel.HOLDER_ELEMENT;
      html.window.document.append(div);
    }
    div.style.visibility = "visible";


    html.InputElement fileElement = html.querySelector(IOModel.FILE_ELEMENT);
    if(fileElement == null){
      fileElement = new html.InputElement(type: "file");
      fileElement.id = IOModel.FILE_ELEMENT;
      div.append(fileElement);
    }
    fileElement.style.visibility = "visible";
    fileElement.focus();

    dispatchCompleteEvent(div);

  }
}
