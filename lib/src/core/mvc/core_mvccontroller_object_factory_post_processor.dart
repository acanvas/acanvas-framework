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
	 * <code>IObjectFactoryPostProcessor</code> that checks the specified <code>IConfigurableListableObjectFactory</code>
	 * if it contains an <code>MVCRouteEventsMetaDataPostProcessor</code>. If not, it creates one and adds it to
	 * the <code>IConfigurableListableObjectFactory</code> using its <code>addObjectPostProcessor()</code> method.
	 * <p>After that it loops through all the object definitions and examines each class for the presence of [Command]
	 * metadata annotations.</p>
	 * <p>Any class can be annotated with [Command] metadata, as long as some metadata keys are provided as well.</p>
	 * <p>What follows are some examples of typical usage:</p>
	 * <p>If an object acts as a command that needs to be executed after a specific event type was dispatched add
	 * this metadata to the class:</p>
	 * <pre>
	 * [Command(eventType="someEventType")]
	 *  class SomeCommandClass {
	 * //implementation ommitted...
	 * }
	 * </pre>
	 * <p>If the command needs to be excecuted after a specific event <code>Class</code> was dispatched then add this
	 * metadata:</p>
	 * <pre>
	 * [Command(eventClass="com.events.MyEvent")]
	 *  class SomeCommandClass {
	 * //implementation ommitted...
	 * }
	 * </pre>
	 * <p>By default the method that will be invoked on the command object will be 'execute', but it is also possible
	 * to specify the method like this:</p>
	 * <pre>
	 * [Command(eventType="someEventType",executeMethod="process")]
	 *  class SomeCommandClass {
	 * //implementation ommitted...
	 * }
	 * </pre>
	 * <p>If more than one command is to be executed after a specific event and it is needed to control the order in
	 * which these command will be executed, use the priority key:</p>
	 * <pre>
	 * [Command(eventType="someEventType",priority=10)]
	 *  class SomeCommandClass {
	 * //implementation ommitted...
	 * }
	 * </pre>
	 * <p>Properties on the <code>Event</code> instance can be mapped to the arguments of the specified execution
	 * method or to properties on the command instance.</p>
	 * <p>First there will be a check if the first argument for the specified execute method is of the same type
	 * as the associated event, in this case the event is simply passed into the execute method.</p>
	 * <p>If this is not the case the properties of the event or the properties defined by the <code>properties</code>
	 * metadata key will be mapped by type to the arguments of the execute method.</p>
	 * <p>Finally, if this is not possible, the properties on the event will be mapped by type to the properties on
	 * the command instance.</p>
	 * <p>[Command] annotations can be stacked, so one command class can be triggered by multiple <code>Events</code>.</p>
	 * @author Roland Zwaga
	 */
	 class CoreMVCControllerObjectFactoryPostProcessor extends AbstractOrderedFactoryPostProcessor{

		/**
		 * The object name that will be given to the controller instance in the object factory
		 */
		 static const String CONTROLLER_OBJECT_NAME = "CoreMVCControllerObjectFactoryPostProcessor";

		 static const String METADATAPROCESSOR_OBJECT_NAME = "SpringActionScriptMVCRouteEventsMetaDataProcessor";

		 static const String COMMAND_METADATA = "Command";

		 static const String EXECUTE_METHOD_METADATA_KEY = "executeMethod";

		 static const String EVENT_TYPE_METADATA_KEY = "eventType";

		 static const String EVENT_CLASS_METADATA_KEY = "eventClass";

		 static const String PRIORITY_METADATA_KEY = "priority";

		 static const String PROPERTIES_METADATA_KEY = "properties";

		 static const String DEFAULT_EXECUTE_METHOD_NAME = "execute";

		/**
		 * Creates a new <code>MVCControllerObjectFactoryPostProcessor</code> instance.
		 */
	 CoreMVCControllerObjectFactoryPostProcessor(int order) : super(order){
		}

		/**
		 *
		 * @param objectFactory The specified <code>IConfigurableListableObjectFactory</code> instance.
		 */
		@override IOperation postProcessObjectFactory(IObjectFactory objectFactory)
		 {
			Assert.notNull(objectFactory, "the objectFactory argument must not be null");
			addMVControllerInstance(objectFactory);
			return null;
		}

		/**
		 * Checks if the specified <code>IConfigurableListableObjectFactory</code> instance contains an object that
		 * implements the <code>IController</code> abstract class. When none is found a <code>Controller</code> instance
		 * is created and registered as a singleton in the <code>IConfigurableListableObjectFactory</code> instance.
		 * @param objectFactory The specified <code>IConfigurableListableObjectFactory</code> instance.
		 * @return The created or retrieved <code>IController</code> instance.
		 */ void addMVControllerInstance(IObjectFactory objectFactory)
		 {
			Assert.notNull(objectFactory, "the objectFactory argument must not be null");
			List<String> names = objectFactory.objectDefinitionRegistry.getObjectDefinitionNamesForType(IController);
			if (names == null) {
				IController controller = objectFactory.createInstance(CoreController, CONTROLLER_OBJECT_NAME);
				objectFactory.cache.putInstance(CONTROLLER_OBJECT_NAME, controller);
			} else {
			}
		}

	}

