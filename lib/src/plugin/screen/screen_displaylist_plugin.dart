part of acanvas_framework.screen;

class ScreenDisplaylistPlugin extends ScreenPluginBase {
  /**
   * Registers Commands with FrontController
   * You can then access them from anywhere:
   * new AcSignal(StateEvents.SOME_COMMAND, optionalParam, optionalCompleteCallback).dispatch();
   */
  @override
  void configureCommands() {
    super.configureCommands();

    commandMap[ScreenDisplaylistEvents.SCREEN_INIT] =
        () => new ScreenInitCommand();
    commandMap[ScreenDisplaylistEvents.SCREEN_LOAD] =
        () => new ScreenLoadCommand();
    commandMap[ScreenDisplaylistEvents.TRANSITION_PREPARE] =
        () => new ScreenTransitionPrepareCommand();
    commandMap[ScreenDisplaylistEvents.APPEAR] =
        () => new ScreenAppearCommand();
    commandMap[ScreenDisplaylistEvents.DISAPPEAR] =
        () => new ScreenDisappearCommand();
    commandMap[ScreenDisplaylistEvents.TRANSITION_RUN] =
        () => new ScreenTransitionRunCommand();
    commandMap[ScreenDisplaylistEvents.APPLY_EFFECT_IN] =
        () => new ScreenApplyEffectInCommand();
    commandMap[ScreenDisplaylistEvents.APPLY_EFFECT_OUT] =
        () => new ScreenApplyEffectOutCommand();

    commandMap[StateEvents.STATE_CHANGE] = () => new ScreenSetCommand();
  }

  /**
   * Register this Plugin's Model as injectable
   * Any class requiring this Model can implement IStateModelAware and the ObjectFactory will take care.
   * This is called Interface Injection, the only kind of injection available in Spring Dart so far.
   * Feel free to add more injectors.
   */
  @override
  void configureInjectors() {
    super.configureInjectors();
    AcContextUtil.registerInstance(objectFactory, ScreenPluginBase.SERVICE_UI,
        new ScreenDisplaylistService());
  }
}
