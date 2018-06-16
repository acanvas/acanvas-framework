part of acanvas_framework.core;

/**
 * @author nilsdoehring
 */
class CommandVO {
  ICommand command;
  AcSignal event;

  CommandVO(ICommand command, AcSignal event) {
    this.event = event;
    this.command = command;
  }
}
