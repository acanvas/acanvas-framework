part of rockdot_framework.ugc;

class UGCPlugin extends AbstractOrderedFactoryPostProcessor {
  static const String MODEL_UGC = "MODEL_UGC";
  Logger _log = new Logger("UGCPlugin");

  UGCPlugin() : super(40) {

  }

  @override IOperation postProcessObjectFactory(IObjectFactory objectFactory) {

    /* Objects */
    RdContextUtil.registerInstance(objectFactory, MODEL_UGC, new UGCModel());

    /* Object Postprocessors */
    objectFactory.addObjectPostProcessor(new UGCModelInjector(objectFactory));


    /* Commands */
    Map commandMap = new Map();

    /* AMF */
    commandMap[UGCEvents.CREATE_ITEM] = () => new UGCCreateItemCommand();
    commandMap[UGCEvents.READ_ITEM] = () => new UGCReadItemCommand();

    commandMap[UGCEvents.READ_ITEM_CONTAINER] = () => new UGCReadItemContainerCommand();
    commandMap[UGCEvents.READ_ITEM_CONTAINERS_UID] = () => new UGCReadItemContainersByUIDCommand();
    commandMap[UGCEvents.CREATE_ITEM_CONTAINER] = () => new UGCCreateItemContainerCommand();

    /* Gaming */
    commandMap[GamingEvents.SET_SCORE_AT_LEVEL] = () => new GamingSetScoreAtLevelCommand();
    commandMap[GamingEvents.GET_HIGHSCORE] = () => new GamingGetHighscoreCommand();
    commandMap[GamingEvents.GET_GAMES] = () => new GamingGetGamesCommand();
    commandMap[GamingEvents.CHECK_PERMISSION_TO_PLAY] = () => new GamingCheckPermissionToPlayCommand();
    commandMap[GamingEvents.CHECK_PERMISSION_TO_PLAY_LOCALE] = () => new GamingCheckPermissionToPlayLocaleCommand();
    commandMap[GamingEvents.SAVE_GAME] = () => new GamingSaveGameCommand();

    /* UGC (User Generated Content) */
    commandMap[UGCEvents.INIT] = () => new UGCInitCommand();
    commandMap[UGCEvents.TEST] = () => new UGCTestCommand();
    commandMap[UGCEvents.USER_REGISTER] = () => new UGCRegisterCommand();
    commandMap[UGCEvents.USER_REGISTER_EXTENDED] = () => new UGCRegisterExtendedCommand();
    commandMap[UGCEvents.USER_HAS_EXTENDED] = () => new UGCHasExtendedUserCommand();
    commandMap[UGCEvents.USER_HAS_EXTENDED_TODAY] = () => new UGCHasExtendedUserTodayCommand();

    commandMap[UGCEvents.ITEM_LIKE] = () => new UGCLikeCommand();
    commandMap[UGCEvents.ITEM_UNLIKE] = () => new UGCUnlikeCommand();
    commandMap[UGCEvents.ITEM_RATE] = () => new UGCRateCommand();

    commandMap[UGCEvents.ITEM_COMPLAIN] = () => new UGCComplainCommand();
    commandMap[UGCEvents.ITEM_DELETE] = () => new UGCDeleteCommand();
    commandMap[UGCEvents.ITEMS_FILTER] = () => new UGCFilterItemCommand();
    commandMap[UGCEvents.ITEMS_FRIENDS_GET] = () => new UGCFriendsReadCommand();
    commandMap[UGCEvents.ITEM_LIKERS_GET] = () => new UGCGetLikersCommand();
    commandMap[UGCEvents.USER_MAIL_SEND] = () => new UGCMailSendCommand();

    commandMap[UGCEvents.TRACK_INVITE] = () => new UGCTrackInviteCommand();

    commandMap[UGCEvents.TASK_GET_CATEGORIES] = () => new TaskGetCategoriesCommand();
    commandMap[UGCEvents.TASK_GET_TASK_BY_CATEGORY] = () => new TaskGetTasksByCategoryCommand();

    RdContextUtil.registerCommands(objectFactory, commandMap);


    /* Bootstrap Command */
    RdConstants.getBootstrap().add(UGCEvents.INIT);


    return null;
  }


}
