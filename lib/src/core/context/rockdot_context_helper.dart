part of stagexl_rockdot;

   class RockdotContextHelper{
    
     static void wire(dynamic uie)
     {
      RockdotConstants.getContext().wire(uie);
    }

     static void registerCommands(IObjectFactory objectFactory,Map map)
     {
      IController controller = objectFactory.getObject(MVCControllerObjectFactoryPostProcessor.CONTROLLER_OBJECT_NAME);
      for (String commandName in map.keys) {
        registerCommand(objectFactory, commandName, map[commandName], ObjectDefinitionScope.PROTOTYPE, controller);

      }
    }

     static void registerCommand(IObjectFactory objectFactory,String commandName,Type clazz,ObjectDefinitionScope scope,[IController controller=null])
     {
      if(controller == null){
        controller = objectFactory.getObject(MVCControllerObjectFactoryPostProcessor.CONTROLLER_OBJECT_NAME);
      }
      ObjectDefinition objectDefinition = new ObjectDefinition( reflectClass(clazz).qualifiedName.toString());
      objectDefinition.name = commandName;
      objectDefinition.clazz = clazz;
      objectDefinition.isLazyInit = true;
      objectDefinition.scope = scope;
      objectDefinition.autoWireMode = AutowireMode.NO;
      objectFactory.objectDefinitionRegistry.registerObjectDefinition(commandName, objectDefinition);
      controller.registerCommandForEventType(commandName, commandName, MVCControllerObjectFactoryPostProcessor.DEFAULT_EXECUTE_METHOD_NAME);
    }

     static void registerClass(IObjectFactory objectFactory,String id,Type clazz,[bool singleton=false,bool isLazyInit=true])
     {
      ObjectDefinition objectDefinition = new ObjectDefinition(reflectClass(clazz).qualifiedName.toString());
      objectDefinition.name = id;
      objectDefinition.clazz = clazz;
      objectDefinition.isLazyInit = isLazyInit;
      objectDefinition.scope = singleton ? ObjectDefinitionScope.SINGLETON : ObjectDefinitionScope.PROTOTYPE;
      objectDefinition.autoWireMode = AutowireMode.NO;
      objectFactory.objectDefinitionRegistry.registerObjectDefinition(id, objectDefinition);
    }

     static void registerScreen(IObjectFactory objectFactory,String id,Type clazz,int tree_order,int tree_parent,String transition,String url, [String substate = StateConstants.SUB_NORMAL])
     {
       RockdotContextHelper.registerClass(objectFactory, id, clazz, false, true);
       
       StateVO stateVO = objectFactory.createInstance(StateVO, "vo." + id);
           stateVO.tree_order = tree_order;
           stateVO.tree_parent = tree_parent;
           stateVO.transition = transition;
           stateVO.url = url;
           stateVO.substate = substate;
           stateVO.property_key = id;
           stateVO.view_id = id;
           objectFactory.cache.putInstance("vo." + id, stateVO);
           
    }
    
     static String getConfigLocation()
     {
      /* Define URL to load from */
      String prefix = RockdotConstants.HOST_FRONTEND + RockdotConstants.VERSION + "/" ;

      /* Define Caching */
      String postfix = RockdotConstants.DEBUG && !DeviceDetector.IS_MOBILE ? "?" + new Random().nextInt(1000000).toString() : "";

      /* Define Context XML */
      return prefix + "app-context.xml" + postfix;
    }

  }

