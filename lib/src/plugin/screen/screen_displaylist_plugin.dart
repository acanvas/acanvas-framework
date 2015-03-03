part of stagexl_rockdot.screen;

class ScreenDisplaylistPlugin extends ScreenPluginBase {

  /**
   * Registers Commands with FrontController 
   * You can then access them from anywhere:
   * new XLSignal(StateEvents.SOME_COMMAND, optionalParam, optionalCompleteCallback).dispatch();
   */
  @override void configureCommands() {
    super.configureCommands();

    commandMap[ScreenDisplaylistEvents.SCREEN_INIT] = ScreenInitCommand;
    commandMap[ScreenDisplaylistEvents.TRANSITION_PREPARE] = ScreenTransitionPrepareCommand;
    commandMap[ScreenDisplaylistEvents.APPEAR] = ScreenAppearCommand;
    commandMap[ScreenDisplaylistEvents.DISAPPEAR] = ScreenDisappearCommand;
    commandMap[ScreenDisplaylistEvents.TRANSITION_RUN] = ScreenTransitionRunCommand;
    commandMap[ScreenDisplaylistEvents.APPLY_EFFECT_IN] = ScreenApplyEffectInCommand;
    commandMap[ScreenDisplaylistEvents.APPLY_EFFECT_OUT] = ScreenApplyEffectOutCommand;

    commandMap[StateEvents.STATE_CHANGE] = ScreenSetCommand;
  }

  /**
     * Register this Plugin's Model as injectable
     * Any class requiring this Model can implement IStateModelAware and the ObjectFactory will take care.
     * This is called Interface Injection, the only kind of injection available in Spring Dart so far.
     * Feel free to add more injectors. 
     */
  @override void configureInjectors() {
    super.configureInjectors();
    RockdotContextHelper.registerInstance(objectFactory, ScreenPluginBase.SERVICE_UI, new ScreenDisplaylistService());
  }
}
