part of stagexl_rockdot;

class StatePlugin extends AbstractPlugin {
  StatePlugin() : super(10) {
  }

  /**
   * Registers Commands with FrontController 
   * You can then access them from anywhere:
   * new XLSignal(StateEvents.SOME_COMMAND, optionalParam, optionalCompleteCallback).dispatch();
   */
  @override void configureCommands() {
    commandMap[StateEvents.INIT] = StatePluginInitCommand;

    // 1. dispatched by button, sent to proxy
    commandMap[StateEvents.ADDRESS_SET] = StateAddressSetCommand;

    // 2. select page vo by url, received from proxy
    commandMap[StateEvents.STATE_REQUEST] = StateRequestCommand;

    // 3. set page vo
    commandMap[StateEvents.STATE_VO_SET] = StateSetCommand;
    commandMap[StateEvents.STATE_VO_FORWARD] = StateForwardCommand;
    commandMap[StateEvents.STATE_VO_BACK] = StateBackCommand;

    // 4b. if it's the same state, only change params
    commandMap[StateEvents.STATE_PARAMS_CHANGE] = StateSetParamsCommand;
    // ## COMMAND INSERTION PLACEHOLDER - DO NOT REMOVE ## //


    /* Add this Plugin's Init Command to Bootstrap Command Sequence */
    projectInitCommand = StateEvents.INIT;
  }

  /**
     * Register this Plugin's Model as injectable
     * Any class requiring this Model can implement IStateModelAware and the ObjectFactory will take care.
     * This is called Interface Injection, the only kind of injection available in Spring Dart so far.
     * Feel free to add more injectors. 
     */
  @override void configureInjectors() {
    RockdotContextHelper.registerInstance(objectFactory, StateConstants.CTX_MODEL_STATE, new StateModel());
    objectFactory.addObjectPostProcessor(new StateModelInjector(objectFactory));
  }

}
