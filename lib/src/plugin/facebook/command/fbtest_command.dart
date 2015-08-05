part of stagexl_rockdot.facebook;

//@retain
class FBTestCommand extends AbstractFBCommand {

  @override void execute([XLSignal event = null]) {
    super.execute(event);

    CompositeCommandWithEvent compositeCommand = new CompositeCommandWithEvent(CompositeCommandKind.SEQUENCE);


    /* ******************** LOGIN USER ******************* */
    String perms = getProperty("project.facebook.permissions");
    compositeCommand.addCommandEvent(new XLSignal(FBEvents.USER_LOGIN, perms, _onUserLogin), applicationContext);

    /* ******************** GET INFO FOR USER ******************* */
    compositeCommand.addCommandEvent(new XLSignal(FBEvents.USER_GETINFO, null, _onUserGetInfo), applicationContext);

    /* ******************** GET FRIENDS OF USER ******************* */
    compositeCommand.addCommandEvent(new XLSignal(FBEvents.FRIENDS_GET, null, _onFriendsGet), applicationContext);

    /* ******************** GET FRIENDS INFO OF USER ******************* */
    compositeCommand.addCommandEvent(new XLSignal(FBEvents.FRIENDS_GETINFO, null, _onFriendsGetInfo), applicationContext);

    /* ******************** GET ALBUMS OF USER ******************* */
    compositeCommand.addCommandEvent(new XLSignal(FBEvents.ALBUMS_GET, null, _onAlbumsGet), applicationContext);

    /* ******************** INVITE USERS ******************* */
    //new BaseEvent(FBEvents.PROMPT_INVITE, new VOFBInvite(getProperty("fanbook.invite.title", true), getProperty("fanbook.invite.message", true), "item_container_id=" + _bitburgerModel.ownAlbum.id), _onInviteFinished);


    compositeCommand.failOnFault = true;
    compositeCommand.addCompleteListener(dispatchCompleteEvent);
    compositeCommand.addErrorListener(dispatchErrorEvent);
    compositeCommand.execute();
  }


  void _onUserLogin([OperationEvent event = null]) {
    Assert.isTrue(_fbModel.userIsAuthenticated == true, "_fbModel.userIsAuthenticated is false");
    Assert.notNull(_fbModel.userPermissions, "_fbModel.userPermissions is null");
  }

  void _onUserGetInfo(FBUserVO dao) {
    Assert.notNull(dao, "FBUserDAO is null");
    this.log.debug("FB User email: " + dao.email);
    this.log.debug("FB User is_app_user: " + dao.is_app_user.toString());
    this.log.debug("FB User birthday_date: " + dao.birthday_date);
    this.log.debug("FB User hometown_location: " + dao.hometown_location);
    this.log.debug("FB User locale: " + dao.locale);
  }

  void _onFriendsGet(List friends) {
    Assert.notNull(friends, "friends is null");
    Assert.notNull(_fbModel.friends, "_fbModel.friends is null");
    this.log.debug("_onFriendsGet, num of Friends: " + _fbModel.friends.length.toString());
  }

  void _onFriendsGetInfo(List friendsWithAdditionalInfo) {
    Assert.notNull(friendsWithAdditionalInfo, "friendsWithAdditionalInfo is null");
    Assert.notNull(_fbModel.friendsWithAdditionalInfo, "_fbModel.friendsWithAdditionalInfo is null");
    this.log.debug("_onFriendsGetInfo, num of Friends with additional info: " + _fbModel.friendsWithAdditionalInfo.length.toString());
    this.log.debug("_onFriendsGetInfo, num of Friends who are App Users: " + _fbModel.friendsWhoAreAppUsers.length.toString());
  }

  void _onAlbumsGet(List userAlbums) {
    Assert.notNull(userAlbums, "userAlbums is null");
    Assert.notNull(_fbModel.userAlbums, "_fbModel.userAlbums is null");
    this.log.debug("_onAlbumsGet, num of Albums: " + _fbModel.userAlbums.length.toString());

    /* ******************** GET PHOTOS OF FIRST USER ALBUM ******************* */
    new XLSignal(FBEvents.PHOTOS_GET, new FBAlbumVO(_fbModel.userAlbums[0]).id, _onAlbumPhotosGet).dispatch();
  }

  void _onAlbumPhotosGet(List userAlbumPhotos) {
    Assert.notNull(userAlbumPhotos, "userAlbumPhotos is null");
    Assert.notNull(_fbModel.userAlbumPhotos, "_fbModel.userAlbumPhotos is null");
    this.log.debug("_onAlbumPhotosGet, num of userAlbumPhotos: " + _fbModel.userAlbumPhotos.length.toString());
  }
}
