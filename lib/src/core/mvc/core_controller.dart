/*
 * Copyright 2007-2011 the original author or authors.
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
	 * Dispatched when a command object is registered with the current <code>Controller</code>.
	 * @eventType org.springextensions.actionscript.core.mvc.event.ControllerRegistrationEvent.COMMAND_REGISTERED
	 */
// [Event(name="controllerCommandRegistered", type="org.springextensions.actionscript.mvc.event.ControllerRegistrationEvent")]
/**
	 * Dispatched before a command object is invoked by the current <code>Controller</code>.
	 * @eventType org.springextensions.actionscript.core.mvc.event.ControllerEvent.BEFORE_COMMAND_EXECUTED
	 */
// [Event(name="controllerBeforeCommandExecuted", type="org.springextensions.actionscript.mvc.event.ControllerEvent")]
/**
	 * Dispatched after a command object was invoked by the current <code>Controller</code>.
	 * @eventType org.springextensions.actionscript.core.mvc.event.ControllerEvent.AFTER_COMMAND_EXECUTED
	 */
// [Event(name="controllerAfterCommandExecuted", type="org.springextensions.actionscript.mvc.event.ControllerEvent")]
/**
	 * <p><code>IController</code> implementation that uses an <code>IApplicationContext</code> instance
	 * as its command factory.</p>
	 * @inheritDoc
	 */
@retain
class CoreController extends EventDispatcher implements IController, IApplicationContextAware {

  RockdotLogger LOGGER;
  IEventBus _eventBus;
  List<String> _eventTypeRegistry;

  /**
		 * If <code>true</code> events dispatched by the current <code>Controller</code> will also be
		 * dispatched through the assigned <code>IEventBus</code> instance.
		 * @default true
		 */
  bool eventBusDispatching = true;

  /**
		 * Creates a new <code>CommandRegistry</code> instance.
		 */
  CoreController() : super() {
    LOGGER = new RockdotLogger("CoreController");
    init();
  }

  /**
		 * Initializes the current <code>Controller</code>
		 */ void init() {
    _eventBus = new DartEventBus();
    clear();
  }


  IApplicationContext _applicationContext;

  /**
		 * The <code>IApplicationContext</code> instance that is used as a command factory.
		 */
  IApplicationContext get applicationContext {
    return _applicationContext;
  }

  /**
		 * @
		 */
  void set applicationContext(IApplicationContext value) {
    _applicationContext = value;
  }

  /**
		 * @inheritDoc
		 */ void clear() {
    _eventTypeRegistry = new List<String>();
  }

  /**
		 * @inheritDoc
		 */
  void registerCommandForEventType(String eventType, String commandName, String executeMethodName, [List<String> properties = null, int priority = 0]) {
    //Assert.hasText(eventType, "eventType argument must not be null or empty");
    //Assert.hasText(commandName, "commandName argument must not be null or empty");
    //Assert.hasText(executeMethodName, "executeMethodName argument must not be null or empty");
    LOGGER.info("command {0} registered for event type {1} with execute method {2} and priority {3}", [commandName, eventType, executeMethodName, priority]);
    _eventBus.addEventListener(eventType, (event) {
      (_applicationContext.getObject(commandName) as ICommand).execute(event);
    });

    _eventTypeRegistry.add(eventType);

  }


  bool _failOnCommandNotFound = false;

  /**
		 * @inheritDoc
		 */
  bool get failOnCommandNotFound {
    return _failOnCommandNotFound;
  }

  /**
		 * @
		 */
  void set failOnCommandNotFound(bool value) {
    _failOnCommandNotFound = value;
  }

}
