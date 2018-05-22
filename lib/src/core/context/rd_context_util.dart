part of rockdot_framework.core;

class RdContextUtil {
  static void wire(dynamic uie) {
    RdConstants.getContext()?.wire(uie);
  }

  static dynamic getObject(String obj) {
    return RdConstants.getContext().getObject(obj);
  }

  static void registerCommands(
      IObjectFactory objectFactory, Map<String, Function> map) {
    IController controller = objectFactory.getObject(
        MVCControllerObjectFactoryPostProcessor.CONTROLLER_OBJECT_NAME);
    for (String commandName in map.keys) {
      registerCommandFunction(objectFactory, commandName, map[commandName],
          ObjectDefinitionScope.PROTOTYPE, controller);
    }
  }

  static void registerCommand(IObjectFactory objectFactory, String commandName,
      Type clazz, ObjectDefinitionScope scope,
      [IController controller = null]) {
    if (controller == null) {
      controller = objectFactory.getObject(
          MVCControllerObjectFactoryPostProcessor.CONTROLLER_OBJECT_NAME);
    }
    ObjectDefinition objectDefinition = new ObjectDefinition(commandName);
    objectDefinition.name = commandName;
    objectDefinition.clazz = clazz;
    objectDefinition.isLazyInit = true;
    objectDefinition.scope = scope;
    objectDefinition.autoWireMode = AutowireMode.NO;
    objectFactory.objectDefinitionRegistry
        .registerObjectDefinition(commandName, objectDefinition);
    controller.registerCommandForEventType(commandName, commandName,
        MVCControllerObjectFactoryPostProcessor.DEFAULT_EXECUTE_METHOD_NAME);
  }

  static void registerCommandFunction(IObjectFactory objectFactory,
      String commandName, Function func, ObjectDefinitionScope scope,
      [IController controller = null]) {
    if (controller == null) {
      controller = objectFactory.getObject(
          MVCControllerObjectFactoryPostProcessor.CONTROLLER_OBJECT_NAME);
    }
    ObjectDefinition objectDefinition = new ObjectDefinition(commandName);
    objectDefinition.name = commandName;
    objectDefinition.func = func;
    objectDefinition.isLazyInit = true;
    objectDefinition.scope = scope;
    objectDefinition.autoWireMode = AutowireMode.NO;
    objectFactory.objectDefinitionRegistry
        .registerObjectDefinition(commandName, objectDefinition);
    controller.registerCommandForEventType(commandName, commandName,
        MVCControllerObjectFactoryPostProcessor.DEFAULT_EXECUTE_METHOD_NAME);
  }

  static void registerClass(IObjectFactory objectFactory, String id, Type clazz,
      [bool singleton = false, bool isLazyInit = true]) {
    ObjectDefinition objectDefinition = new ObjectDefinition(id);
    objectDefinition.name = id;
    objectDefinition.clazz = clazz;
    objectDefinition.isLazyInit = isLazyInit;
    objectDefinition.scope = singleton
        ? ObjectDefinitionScope.SINGLETON
        : ObjectDefinitionScope.PROTOTYPE;
    objectDefinition.autoWireMode = AutowireMode.NO;
    objectFactory.objectDefinitionRegistry
        .registerObjectDefinition(id, objectDefinition);
  }

  static void registerClassFunction(
      IObjectFactory objectFactory, String id, Function func,
      [bool singleton = false, bool isLazyInit = true]) {
    ObjectDefinition objectDefinition = new ObjectDefinition(id);
    objectDefinition.name = id;
    objectDefinition.func = func;
    objectDefinition.isLazyInit = isLazyInit;
    objectDefinition.scope = singleton
        ? ObjectDefinitionScope.SINGLETON
        : ObjectDefinitionScope.PROTOTYPE;
    objectDefinition.autoWireMode = AutowireMode.NO;
    objectFactory.objectDefinitionRegistry
        .registerObjectDefinition(id, objectDefinition);
  }

  static void registerInstance(
      IObjectFactory objectFactory, String id, dynamic clazz) {
    wire(clazz);
    objectFactory.cache.putInstance(id, clazz);
  }

  static void registerScreen(
      IObjectFactory objectFactory, String id, Function func, String url,
      {String substate: StateConstants.SUB_NORMAL,
      int tree_order: 0,
      int tree_parent: 0,
      String transition: "transition.default"}) {
    RdContextUtil.registerClassFunction(objectFactory, id, func, false, true);

    StateVO stateVO = new StateVO();
    stateVO.tree_order = tree_order;
    stateVO.tree_parent = tree_parent;
    stateVO.transition = transition;
    stateVO.url = url;
    stateVO.substate = substate;
    stateVO.propertyKey = id;
    stateVO.view_id = id;
    //objectFactory.cache.putInstance("vo." + id, stateVO);
    StateModel m =
        objectFactory.getObject(StateConstants.CTX_MODEL_STATE) as StateModel;
    m.addStateVO(stateVO);
  }

  static void registerScreenInstance(IObjectFactory objectFactory, String id,
      RockdotLifecycleSprite clazz, String url,
      {String substate: StateConstants.SUB_NORMAL,
      int tree_order: 0,
      int tree_parent: 0,
      String transition: "transition.default"}) {
    wire(clazz);
    objectFactory.cache.putInstance(id, clazz);

    StateVO stateVO = new StateVO();
    stateVO.tree_order = tree_order;
    stateVO.tree_parent = tree_parent;
    stateVO.transition = transition;
    stateVO.url = url;
    stateVO.substate = substate;
    stateVO.propertyKey = id;
    stateVO.view_id = id;
    objectFactory.cache.putInstance("vo." + id, stateVO);
  }

  static String getConfigLocation() {
    /* Define URL to load from */
    String prefix = RdConstants.HOST_FRONTEND + RdConstants.VERSION + "/";

    /* Define Caching */
    String postfix = RdConstants.DEBUG && !Rd.MOBILE
        ? "?" + new math.Random().nextInt(1000000).toString()
        : "";

    /* Define Context XML */
    return prefix + "app-context.xml" + postfix;
  }
}
