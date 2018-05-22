part of rockdot_framework.ugc;

class UGCTestCommand extends AbstractUGCCommand {
  int _itemContainerID = 1;
  int _itemID = 1;

  @override
  void execute([RdSignal event = null]) {
    super.execute(event);

    CompositeCommandWithEvent compositeCommand =
        new CompositeCommandWithEvent(CompositeCommandKind.SEQUENCE);

    /* ******************** REGISTER USER ******************* */

    UGCUserDTO user = new UGCUserDTO();
    user.network = UGCUserDTO.NETWORK_INPUTFORM;
    user.name = "Test User";
    user.pic =
        "http://profile.ak.fbcdn.net/static-ak/rsrc.php/v1/yo/r/UlIqmHJn-SK.gif";
    user.uid = "1234567890";
    user.locale = "de_DE";

    compositeCommand.addCommandEvent(
        new RdSignal(UGCEvents.USER_REGISTER, user, _onUserRegister),
        applicationContext);

    /* ******************** REGISTER USER (EXTENDED) ******************* */

    UGCUserExtendedDTO userExt = new UGCUserExtendedDTO();
    userExt.hometown_location = "Musterstadt, Germany";
    userExt.email = "ugc-text@email.com";
    userExt.email_confirmed = 0;
    userExt.birthday_date = "1981-12-24";
    userExt.firstname = "UGC-Test";
    userExt.lastname = "DBUser";
    userExt.street = "Nopestraße 124";
    userExt.city = "70190 Nowhere";

    compositeCommand.addCommandEvent(
        new RdSignal(
            UGCEvents.USER_REGISTER_EXTENDED, userExt, _onUserRegisterExtended),
        applicationContext);

    /* ******************** SEND CONFIRMATION MAIL ******************* */

    //compositeCommand.addCommandEvent(new RdSignal(UGCEvents.USER_MAIL_SEND, null, _onMailSent), applicationContext);

    /* ******************** CREATE ITEM CONTAINER ******************* */

    UGCItemContainerDTO albumVO = new UGCItemContainerDTO();
    albumVO.creator_uid = user.uid;
    albumVO.title = "Album von " + user.name;

    compositeCommand.addCommandEvent(
        new RdSignal(
            UGCEvents.CREATE_ITEM_CONTAINER, albumVO, _onCreateItemContainer),
        applicationContext);

    /* ******************** CREATE IMAGE ITEM ******************* */

    //Database Item VO
    UGCItemDTO itemDAO = new UGCItemDTO();
    itemDAO.title = "Test Image Title";
    itemDAO.description = "Test Image Description";

    String filenamePrefix =
        "test_" + (new math.Random().nextDouble()).toString();
    String filenameBig = filenamePrefix + ".jpg";
    String filenameThumb = filenamePrefix + "_thumb.jpg";

    UGCImageItemDTO imageDAO = new UGCImageItemDTO();
    imageDAO.url_big = getProperty("project.host.download") + "/" + filenameBig;
    imageDAO.url_thumb =
        getProperty("project.host.download") + "/" + filenameThumb;
    imageDAO.w = 100;
    imageDAO.h = 100;

    itemDAO.type = UGCItemDTO.TYPE_IMAGE;
    itemDAO.type_dao = imageDAO;

    compositeCommand.addCommandEvent(
        new RdSignal(UGCEvents.CREATE_ITEM, itemDAO, _onCreateItem),
        applicationContext);

    /* ******************** READ ITEM CONTAINER ******************* */

    compositeCommand.addCommandEvent(
        new RdSignal(UGCEvents.READ_ITEM_CONTAINER, _itemContainerID,
            _onReadItemContainer),
        applicationContext);

    /* ******************** READ ITEM ******************* */

    compositeCommand.addCommandEvent(
        new RdSignal(UGCEvents.READ_ITEM, _itemID, _onReadItem),
        applicationContext);

    /* ******************** READ ITEM CONTAINERS (BY UID) ******************* */

    compositeCommand.addCommandEvent(
        new RdSignal(
            UGCEvents.READ_ITEM_CONTAINERS_UID, user.uid, _onReadItemByUID),
        applicationContext);

    /* ******************** LIKE ITEM ******************* */

    compositeCommand.addCommandEvent(
        new RdSignal(UGCEvents.ITEM_LIKE, _itemID, _onLikeOrComplainOrRateItem),
        applicationContext);

    /* ******************** COMPLAIN ITEM ******************* */

    compositeCommand.addCommandEvent(
        new RdSignal(
            UGCEvents.ITEM_COMPLAIN, _itemID, _onLikeOrComplainOrRateItem),
        applicationContext);

    /* ******************** RATE ITEM ******************* */
    UGCRatingVO rateItem = new UGCRatingVO(_itemID, 3);
    compositeCommand.addCommandEvent(
        new RdSignal(
            UGCEvents.ITEM_RATE, rateItem, _onLikeOrComplainOrRateItem),
        applicationContext);

    /* ******************** SET GAME SCORE ******************* */
    /*
    UGCGameDTO game = new UGCGameDTO();
    game.level = 1;
    game.score = 1000;
    compositeCommand.addCommandEvent(new RdSignal(GamingEvents.SET_SCORE_AT_LEVEL, game, _onSetScore), applicationContext);
    */

    /* ******************** GET GAME HIGHSCORE ******************* */

    //compositeCommand.addCommandEvent(new RdSignal(GamingEvents.GET_HIGHSCORE, null, _onGetHighscore), applicationContext);

    compositeCommand.failOnFault = true;
    compositeCommand.addCompleteListener(dispatchCompleteEvent);
    compositeCommand.addErrorListener(errorHandler);
    compositeCommand.execute();
  }

/*
  void _onUserRegister([List event = null]) {
    Assert.notNull(event, "result is null");
    UGCUserDTO user = new UGCUserDTO(event.first);
    this.log.info("_onUserRegister, name: ${user.name}");
  }

*/
  void _onUserRegister([int result = null]) {
    this.log.info(
        "_onUserRegister, Insert ID: ${result} (0 if user already present)");
    Assert.notNull(result, "result is null");
  }

  void _onUserRegisterExtended([int result = null]) {
    this.log.info(
        "_onUserRegisterExtended, Insert ID: ${result} (0 if user already present)");
    Assert.notNull(result, "result is null");
  }

  void _onCreateItemContainer([int result = null]) {
    this.log.info(
        "_onCreateItemContainer, Insert ID: ${result} (0 if container already present)");
    Assert.notNull(result, "result is null");
    _itemContainerID = result;
  }

  void _onCreateItem([int result = null]) {
    this.log.info(
        "_onCreateItem, Insert ID: ${result} (0 if item already present)");
    Assert.notNull(result, "result is null");
    _itemID = result;
  }

  void _onReadItemContainer(UGCItemContainerDTO container) {
    Assert.notNull(container, "_onReadItemContainer, container is null");
    Assert.notNull(_ugcModel.currentItemContainerDAO,
        "_onReadItemContainer, _ugcModel.currentItemContainerDAO is null");
  }

  void _onReadItemByUID() {
    this
        .log
        .info("_ugcModel.ownContainers: " + _ugcModel.ownContainers.toString());
    this.log.info(
        "_ugcModel.followContainers: " + _ugcModel.followContainers.toString());
    this.log.info("_ugcModel.participantContainers: " +
        _ugcModel.participantContainers.toString());
  }

  void _onReadItem(UGCItemDTO item) {
    Assert.notNull(item, "_onReadItem, item is null");
    Assert.notNull(_ugcModel.currentItemDAO,
        "_onReadItem, _ugcModel.currentItemDAO is null");
  }

  void _onLikeOrComplainOrRateItem(String str) {
    Assert.isTrue(str == "ok", "Something went wrong in the backend.");
  }

  //ignore: unused_element
  void _onSetScore(Map dao) {
    this.log.info("User Rank: " + dao["rank"].toString());
    this.log.info("User Score: " + dao["score"].toString());
  }

  //ignore: unused_element
  void _onGetHighscore() {
    this.log.info("_ugcModel.gaming.highscoreFriends: " +
        _ugcModel.gaming.highscoreFriends.toString());
    this.log.info("_ugcModel.gaming.highscoreAll: " +
        _ugcModel.gaming.highscoreAll.toString());
    this.log.info("_ugcModel.gaming.rank: " + _ugcModel.gaming.rank.toString());
  }

  //ignore: unused_element
  void _onMailSent(String str) {
    Assert.isTrue(str == "Message successfully sent!",
        "Something went wrong in the backend.");
  }
}
