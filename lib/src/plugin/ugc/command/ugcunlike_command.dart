part of stagexl_rockdot;

@retain
class UGCUnlikeCommand extends AbstractUGCCommand {

  @override void execute([RockdotEvent event = null]) {
    super.execute(event);
    int id = (event.data as UGCRatingVO).id;
    String uid = _ugcModel.userDAO.uid;

    Map dto = {
      'id': id,
      'uid': uid
    };

    amfOperation("UGCEndpoint.unlikeItem", dto);
  }
}
