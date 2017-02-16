part of rockdot_framework.core;

/**
 * @author nilsdoehring
 */
class CommandVO {
  ICommand command;
  RdSignal event;

  CommandVO(ICommand command, RdSignal event) {
    this.event = event;
    this.command = command;
  }
}
