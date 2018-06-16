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
part of acanvas_framework.core;

/**
 *
 * @author Roland Zwaga
 */

class AcContext extends SpringApplicationContext {
  /**
   * Creates a new <code>ApplicationContext</code> instance.
   * @param parent
   * @param objFactory
   */
  AcContext(
      [dynamic source = null,
      IApplicationContext parent = null,
      List<DisplayObject> rootViews = null,
      IObjectFactory objFactory = null])
      : super(rootViews, objFactory) {
    //Only needed if we want to automatically identify FactoryPostProcessors in Context
    //addObjectFactoryPostProcessor(new RegisterObjectFactoryPostProcessorsFactoryPostProcessor(-99));

    objectFactory.addObjectPostProcessor(
        new ApplicationContextAwareObjectPostProcessor(this));

    applicationContextInitializer = new DefaultApplicationContextInitializer();

    /*
      
      XMLObjectDefinitionsProvider provider = new XMLObjectDefinitionsProvider((source != null) ? [source] : null);
      addDefinitionProvider(provider);
      
      /* XML Preprocessor, replacing language placeholders */
      provider.addPreprocessor(new CorePropertyImportPreprocessor(AcanvasConstants.LANGUAGE));

      /* XML Namespace Handlers for acanvas:page and acanvas:transition */
      provider.addNamespaceHandler(new AcanvasCoreNamespaceHandler());
      
      */

    /* MVC Postprocessor (BaseEvent + CoreCommand) */
    addObjectFactoryPostProcessor(
        new MVCControllerObjectFactoryPostProcessor(-98));
  }

  Future initApplication() {
    /* initializing the UI is mandatory, but feel free to add other commands */
    CompositeCommandWithEvent compositeCommand =
        new CompositeCommandWithEvent(CompositeCommandKind.SEQUENCE);

    var array = AcConstants.getBootstrap();
    for (int i = 0; i < array.length; i++) {
      compositeCommand.addCommandEvent(new AcSignal(array[i]), this);
    }

    /* add sequence listeners */
    Completer c = new Completer();
    compositeCommand.addCompleteListener(c.complete);
    compositeCommand.execute();
    return c.future;
  }
}
