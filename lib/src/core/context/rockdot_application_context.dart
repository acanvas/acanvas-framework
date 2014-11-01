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
part of stagexl_rockdot;



  /**
   *
   * @author Roland Zwaga
   */
   
class RockdotApplicationContext extends SpringApplicationContext {

    /**
     * Creates a new <code>ApplicationContext</code> instance.
     * @param parent
     * @param objFactory
     */
   RockdotApplicationContext([dynamic source=null,IApplicationContext parent=null, List<DisplayObject> rootViews=null, IObjectFactory objFactory=null]) : super(rootViews, objFactory) {

      //Only needed if we want to automatically identify FactoryPostProcessors in Context
      //addObjectFactoryPostProcessor(new RegisterObjectFactoryPostProcessorsFactoryPostProcessor(-99));
      

     objectFactory.addObjectPostProcessor(new ApplicationContextAwareObjectPostProcessor(this));

      applicationContextInitializer =  new DefaultApplicationContextInitializer();
      
      /*
      
      XMLObjectDefinitionsProvider provider = new XMLObjectDefinitionsProvider((source != null) ? [source] : null);
      addDefinitionProvider(provider);
      
      /* XML Preprocessor, replacing language placeholders */
      provider.addPreprocessor(new CorePropertyImportPreprocessor(RockdotConstants.LANGUAGE));

      /* XML Namespace Handlers for rockdot:page and rockdot:transition */
      provider.addNamespaceHandler(new RockdotCoreNamespaceHandler());
      
      */

      /* MVC Postprocessor (BaseEvent + CoreCommand) */
      addObjectFactoryPostProcessor(    new MVCControllerObjectFactoryPostProcessor(-98) );
      
    } 
   
   void initApplication(Function completeCallback,Function errorCallback)
     {
      /* initializing the UI is mandatory, but feel free to add other commands */
      CompositeCommandWithEvent compositeCommand = new CompositeCommandWithEvent(CompositeCommandKind.SEQUENCE);

      List array = RockdotConstants.getBootstrap();
      for (int i = 0; i < array.length; i++) {
        compositeCommand.addCommandEvent(new XLSignal(array[i]), this);
      }
    
      /* add sequence listeners */
      compositeCommand.addCompleteListener(completeCallback);
      compositeCommand.addErrorListener(errorCallback);
      compositeCommand.execute();
    } 
    
   

  }

