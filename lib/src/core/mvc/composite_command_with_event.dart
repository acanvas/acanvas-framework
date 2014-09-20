/*
 * Copyright 2007-2010 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
part of rockdot_dart;


/**
	 * Basic implementation of the <code>ICompositeCommand</code> that executes a list of <code>ICommand</code> instances
	 * that were added through the <code>addCommand()</code> method. The commands are executed in the order in which
	 * they were added.
	 * @author Christophe Herreman
	 * @author Roland Zwaga
	 * @docref the_operation_api.html#composite_commands
	 */
class CompositeCommandWithEvent extends AbstractProgressOperation implements ICompositeCommand {

  Logger LOGGER;

  /**
		 * Determines if the execution of all the <code>ICommands</code> should be aborted if an
		 * <code>IAsyncCommand</code> instance dispatches an <code>AsyncCommandFaultEvent</code> event.
		 * @default false
		 * @see org.springextensions.actionscript.core.command.IAsyncCommand IAsyncCommand
		 */
  bool failOnFault = false;

  List<CommandVO> _commands = [];
  int _timer;
  List get commands {
    return _commands;
  }
  void setCommands(List value) {
    _commands = value;
  }

  // --------------------------------------------------------------------
  //
  // Constructor
  //
  // --------------------------------------------------------------------

  /**
		 * Creates a new <code>CompositeCommand</code> instance.
		 * @default CompositeCommandKind.SEQUENCE
		 */
  CompositeCommandWithEvent([String kind = null]) : super() {
    LOGGER = new Logger("CompositeCommandWithEvent");
    _kind = (kind != null) ? kind : CompositeCommandKind.SEQUENCE;
  }

  // --------------------------------------------------------------------
  //
  // Properties
  //
  // --------------------------------------------------------------------

  String _kind;
  String get kind {
    return _kind;
  }
  void set kind(String value) {
    _kind = value;
  }

  /**
		 * @inheritDoc
		 */
  int get numCommands {
    return _commands.length;
  }

  CommandVO _currentCommandVO;

  /**
		 * The <code>ICommand</code> that is currently being executed.
		 */
  CommandVO get currentCommandVO {
    return _currentCommandVO;
  }

  // --------------------------------------------------------------------
  //
  // Implementation: ICommand
  //
  // --------------------------------------------------------------------

  /**
		 * @inheritDoc
		 */
  void execute([RockdotEvent event = null]) {
    if (_commands != null) {
      switch (_kind) {
        case CompositeCommandKind.SEQUENCE:
          LOGGER.info("Executing composite command '{0}' in sequence", [this]);
          executeNextCommand();
          break;
        case CompositeCommandKind.PARALLEL:
          LOGGER.info("Executing composite command '{0}' in parallel", [this]);
          executeCommandsInParallel();
          break;
        default:
          break;
      }
    } else {
      LOGGER.info("No commands were added to this composite command. Dispatching complete event.");
      dispatchCompleteEvent();
    }
  }
  void cancel() {
    _commands = [];
  }


  // --------------------------------------------------------------------
  //
  // Public Methods
  //
  // --------------------------------------------------------------------

  /**
		 * @inheritDoc
		 */
  ICompositeCommand addCommandEvent(RockdotEvent event, IObjectFactory objectFactory) {
    if (event == null) {
      LOGGER.info("The event argument must not be null");
      return null;
    }
    if (objectFactory == null) {
      LOGGER.info("The objectFactory argument must not be null");
      return null;
    }
    _commands.add(new CommandVO(objectFactory.getObject(event.type), event));
    total++;
    return this;
  }
  /*
		ICompositeCommand addOperation(Class operationClass,%# ... constructorArgs%#)
		 {
			assert.notNull(operationClass, "The operationClass argument must not be null");
			throw new IllegalOperationError("method not allowed in this implementation");
			//addCommand(GenericOperationCommand.createNew(operationClass, constructorArgs));
			//return null;
		}
    */
  // --------------------------------------------------------------------
  //
  // Protected Methods
  //
  // --------------------------------------------------------------------

  /**
		 * If the specified <code>ICommand</code> implements the <code>IAsyncCommand</code> abstract class the <code>onCommandResult</code>
		 * and <code>onCommandFault</code> event handlers are added. Before the <code>ICommand.execute()</code> method is invoked
		 * the <code>CompositeCommandEvent.EXECUTE_COMMAND</code> event is dispatched.
		 * <p>When the <code>command</code> argument is <code>null</code> the <code>CompositeCommandEvent.COMPLETE</code> event is dispatched instead.</p>
		 * @see org.springextensions.actionscript.core.command.event.CommandEvent CompositeCommandEvent
		 */ void executeCommand(CommandVO commandVO) {

    if (commandVO == null) {
      LOGGER.info("The 'command' must not be null");
      return;
    }
    LOGGER.info("Executing command: " + commandVO.command.toString());

    _currentCommandVO = commandVO;

    // listen for "result" or "fault" if we have an async command
    addCommandListeners(commandVO.command as IOperation);

    // execute the command
    //TODO why this event?
    dispatchEvent(new CommandEvent(CommandEvent.EXECUTE, commandVO.command));
    dispatchBeforeCommandEvent(commandVO.command);

    // execute the next command if the executed command was synchronous
    if (commandVO.command is IOperation) {
      LOGGER.info("Command '{0}' is asynchronous. Waiting for response.", [commandVO.command]);
    } 
    
    commandVO.command.execute(commandVO.event);
    
    if (!(commandVO.command is IOperation)) {
      dispatchAfterCommandEvent(commandVO.command);
      progress++;
      dispatchProgressEvent();
      LOGGER.info("Command '{0}' is synchronous and is executed. Trying to execute next command.", [commandVO.command]);
      executeNextCommand();
    }

  }

  /**
		 * Retrieves and removes the next <code>ICommand</code> from the internal list and passes it to the
		 * <code>executeCommand()</code> method.
		 */ void executeNextCommand() {
    CommandVO nextCommand = _commands.length > 0 ? _commands.removeAt(0) : null;
    if (_timer == null) {
      _timer = new DateTime.now().millisecondsSinceEpoch;
    }
    int time = new DateTime.now().millisecondsSinceEpoch;

    if (nextCommand != null) {
      LOGGER.info("Executing next command '{0}'. Remaining number of commands: '{1}'. Time: {2}", [nextCommand.command, _commands.length, time - _timer]);
      executeCommand(nextCommand);
    } else {
      LOGGER.info("All commands in '{0}' have been executed. Dispatching 'complete' event.", [this]);
      dispatchCompleteEvent();
    }
  }
  void removeCommand(IOperation asyncCommand) {

    if (asyncCommand == null) {
      LOGGER.info("asyncCommand argument must not be null.");
      return;
    }
    if (_commands != null) {

      for (CommandVO cmd in _commands) {
        int idx = _commands.indexOf(cmd);
        if (idx > -1) {
          _commands.removeAt(idx);
          break;
        }
      }

      if (_commands.length < 1) {
        dispatchCompleteEvent();
      }
    }
  }
  void executeCommandsInParallel() {
    bool containsOperations = false;
    for (CommandVO cmd in _commands) {
      if (cmd.command is IOperation) {
        containsOperations = true;
        addCommandListeners((cmd.command as IOperation));
      }
      dispatchBeforeCommandEvent(cmd.command);
      cmd.command.execute(cmd.event);
      if (!(cmd is IOperation)) {
        dispatchAfterCommandEvent(cmd.command);
      }
    }
    if (!containsOperations) {
      dispatchCompleteEvent();
    }
  }

  /**
		 * Adds the <code>onCommandResult</code> and <code>onCommandFault</code> event handlers to the specified <code>IAsyncCommand</code> instance.
		 */ void addCommandListeners(IOperation asyncCommand) {
    if (asyncCommand != null) {
      asyncCommand.addCompleteListener(onCommandResult);
      asyncCommand.addErrorListener(onCommandFault);
    }
  }

  /**
		 * Removes the <code>onCommandResult</code> and <code>onCommandFault</code> event handlers from the specified <code>IAsyncCommand</code> instance.
		 */ void removeCommandListeners(IOperation asyncCommand) {
    if (asyncCommand != null) {
      asyncCommand.removeCompleteListener(onCommandResult);
      asyncCommand.removeErrorListener(onCommandFault);
    }
  }
  void onCommandResult(OperationEvent event) {
    progress++;
    dispatchProgressEvent();
    LOGGER.info("Asynchronous command '{0}' returned result. Executing next command.", [event.target]);
    removeCommandListeners((event.target as IOperation));
    dispatchAfterCommandEvent((event.target as ICommand));
    switch (_kind) {
      case CompositeCommandKind.SEQUENCE:
        executeNextCommand();
        break;
      case CompositeCommandKind.PARALLEL:
        removeCommand((event.target as IOperation));
        break;
      default:
        break;
    }
  }
  void onCommandFault(OperationEvent event) {
    LOGGER.info("Asynchronous command '{0}' returned error.", [event.target]);
    dispatchErrorEvent(event.error);
    removeCommandListeners(event.target as IOperation);
    switch (_kind) {
      case CompositeCommandKind.SEQUENCE:
        if (failOnFault) {
          _currentCommandVO = null;
        } else {
          executeNextCommand();
        }
        break;
      case CompositeCommandKind.PARALLEL:
        removeCommand((event.target as IOperation));
        break;
      default:
        break;
    }
  }
  void dispatchAfterCommandEvent(ICommand command) {
    if (command == null) {
      LOGGER.warning("the command argument must not be null");
    } else {
      dispatchEvent(new CompositeCommandEvent(CompositeCommandEvent.AFTER_EXECUTE_COMMAND, command));
    }
  }
  void dispatchBeforeCommandEvent(ICommand command) {
    if (command == null) {
      LOGGER.warning("the command argument must not be null");
    } else {
      dispatchEvent(new CompositeCommandEvent(CompositeCommandEvent.BEFORE_EXECUTE_COMMAND, command));
    }
  }
  ICompositeCommand addCommand(ICommand command) {
    return null;
  }
  ICompositeCommand addCommandAt(ICommand command, int index) {
    return null;
  }
  /*
		ICompositeCommand addOperationAt(Class operationClass,int index,%# ... constructorArgs%#)
		 {
			return null;
		}*/



}
