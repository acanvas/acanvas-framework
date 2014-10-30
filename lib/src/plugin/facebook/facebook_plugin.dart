part of stagexl_rockdot;

class FacebookPlugin extends AbstractOrderedFactoryPostProcessor {
  static const String MODEL_FB = "MODEL_FB";
  FacebookPlugin() : super(30) {
  }

  @override
  IOperation postProcessObjectFactory(IObjectFactory objectFactory) {

    /* Objects */
    RockdotContextHelper.registerClass(objectFactory, MODEL_FB, FBModel, true);

    /* Object Postprocessors */
    objectFactory.addObjectPostProcessor(new FBModelInjector(objectFactory));

    /* Commands */
    Map commandMap = new Map();

    commandMap[FBEvents.PROMPT_SHARE] = FBPromptShareCommand;

    commandMap[FBEvents.INIT] = FBInitBrowserCommand;
    commandMap[FBEvents.USER_LOGIN] = FBLoginBrowserCommand;
    commandMap[FBEvents.USER_LOGOUT] = FBLogoutBrowserCommand;
    commandMap[FBEvents.PROMPT_INVITE] = FBPromptInviteBrowserCommand;
    commandMap[FBEvents.TEST] = FBTestCommand;
    commandMap[FBEvents.USER_GETINFO] = FBUserGetInfoCommand;
    commandMap[FBEvents.USER_GETINFO_PERMISSIONS] = FBUserGetInfoPermissionsCommand;
    commandMap[FBEvents.FRIENDS_GET] = FBFriendsGetCommand;
    commandMap[FBEvents.FRIENDS_GETINFO] = FBFriendsGetInfoCommand;
    commandMap[FBEvents.ALBUMS_GET] = FBPhotoGetAlbumsCommand;
    commandMap[FBEvents.PHOTOS_GET] = FBPhotoGetFromAlbumCommand;
    commandMap[FBEvents.PHOTO_UPLOAD] = FBPhotoUploadCommand;

    RockdotContextHelper.registerCommands(objectFactory, commandMap);


    /* Bootstrap Command */
    RockdotConstants.getBootstrap().add(FBEvents.INIT);

    return null;
  }

}
