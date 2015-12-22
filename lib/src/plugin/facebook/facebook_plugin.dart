part of rockdot_framework.facebook;

class FacebookPlugin extends AbstractRdPlugin {
  static const String MODEL_FB = "MODEL_FB";

  FacebookPlugin() : super(30) {
  }

  /**
   * Registers Commands with FrontController
   * You can then access them from anywhere:
   * new RdSignal(FacebookEvents.SOME_COMMAND, optionalParam, optionalCompleteCallback).dispatch();
   */
  @override void configureCommands() {

    commandMap[FBEvents.INIT] = () => new FBInitBrowserCommand();
    commandMap[FBEvents.USER_LOGIN] = () => new FBLoginBrowserCommand();
    commandMap[FBEvents.USER_LOGOUT] = () => new FBLogoutBrowserCommand();
    commandMap[FBEvents.PROMPT_SHARE] = () => new FBPromptShareCommand();
    commandMap[FBEvents.PROMPT_INVITE] = () => new FBPromptInviteBrowserCommand();
    commandMap[FBEvents.TEST] = () => new FBTestCommand();
    commandMap[FBEvents.USER_GETINFO] = () => new FBUserGetInfoCommand();
    commandMap[FBEvents.USER_GETINFO_PERMISSIONS] = () => new FBUserGetInfoPermissionsCommand();
    commandMap[FBEvents.FRIENDS_GET] = () => new FBFriendsGetCommand();
    commandMap[FBEvents.FRIENDS_GETINFO] = () => new FBFriendsGetInfoCommand();
    commandMap[FBEvents.ALBUMS_GET] = () => new FBPhotoGetAlbumsCommand();
    commandMap[FBEvents.PHOTOS_GET] = () => new FBPhotoGetFromAlbumCommand();
    commandMap[FBEvents.PHOTO_UPLOAD] = () => new FBPhotoUploadCommand();

    projectInitCommand = FBEvents.INIT;
  }

  /**
   * Register this Plugin's Model as injectable
   * Any class requiring this Model can implement IFacebookModelAware and the ObjectFactory will take care.
   * This is called Interface Injection, the only kind of injection available in Spring Dart so far.
   * Feel free to add more injectors.
   */
  @override void configureInjectors() {
    RdContextUtil.registerInstance(objectFactory, MODEL_FB, new FBModel());
    objectFactory.addObjectPostProcessor(new FBModelInjector(objectFactory));
  }

}
