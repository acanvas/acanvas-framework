part of stagexl_rockdot.facebook;

class FacebookPlugin extends AbstractPlugin {
  static const String MODEL_FB = "MODEL_FB";
  FacebookPlugin() : super(30) {
  }
  
  /**
   * Registers Commands with FrontController 
   * You can then access them from anywhere:
   * new XLSignal(FacebookEvents.SOME_COMMAND, optionalParam, optionalCompleteCallback).dispatch();
   */
  @override void configureCommands() {

    commandMap[FBEvents.INIT] = FBInitBrowserCommand;
    commandMap[FBEvents.USER_LOGIN] = FBLoginBrowserCommand;
    commandMap[FBEvents.USER_LOGOUT] = FBLogoutBrowserCommand;
    commandMap[FBEvents.PROMPT_SHARE] = FBPromptShareCommand;
    commandMap[FBEvents.PROMPT_INVITE] = FBPromptInviteBrowserCommand;
    commandMap[FBEvents.TEST] = FBTestCommand;
    commandMap[FBEvents.USER_GETINFO] = FBUserGetInfoCommand;
    commandMap[FBEvents.USER_GETINFO_PERMISSIONS] = FBUserGetInfoPermissionsCommand;
    commandMap[FBEvents.FRIENDS_GET] = FBFriendsGetCommand;
    commandMap[FBEvents.FRIENDS_GETINFO] = FBFriendsGetInfoCommand;
    commandMap[FBEvents.ALBUMS_GET] = FBPhotoGetAlbumsCommand;
    commandMap[FBEvents.PHOTOS_GET] = FBPhotoGetFromAlbumCommand;
    commandMap[FBEvents.PHOTO_UPLOAD] = FBPhotoUploadCommand;
    
    projectInitCommand = FBEvents.INIT;
  }

  /**
     * Register this Plugin's Model as injectable
     * Any class requiring this Model can implement IFacebookModelAware and the ObjectFactory will take care.
     * This is called Interface Injection, the only kind of injection available in Spring Dart so far.
     * Feel free to add more injectors. 
     */
  @override void configureInjectors() {
    RockdotContextHelper.registerInstance(objectFactory, MODEL_FB, new FBModel());
    objectFactory.addObjectPostProcessor(new FBModelInjector(objectFactory));
  }

}
