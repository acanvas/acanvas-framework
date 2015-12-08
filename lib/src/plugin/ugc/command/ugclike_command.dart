part of stagexl_rockdot.ugc;

//@retain
class UGCLikeCommand extends AbstractUGCCommand {

  @override void execute([RdSignal event = null]) {
    super.execute(event);
    int id = event.data;
    String uid = _ugcModel.userDAO.uid;

    Map dto = {
      'id': id,
      'uid': uid
    };

    amfOperation("UGCEndpoint.likeItem", map: dto);
  }
}
