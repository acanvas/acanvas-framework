part of rockdot_framework.ugc;

//@retain
class UGCUnlikeCommand extends AbstractUGCCommand {
  @override
  void execute([RdSignal event = null]) {
    super.execute(event);
    int id = (event.data as UGCRatingVO).id;
    String uid = _ugcModel.userDAO.uid;

    Map dto = {'id': id, 'uid': uid};

    amfOperation("UGCEndpoint.unlikeItem", map: dto);
  }
}
