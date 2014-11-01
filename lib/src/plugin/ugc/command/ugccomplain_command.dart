part of stagexl_rockdot;


@retain
class UGCComplainCommand extends AbstractUGCCommand {

  @override void execute([XLSignal event = null]) {
    super.execute(event);

    int id = event.data;
    String uid = _ugcModel.userDAO.uid;

    Map dto = {
      'id': id,
      'uid': uid
    };

    amfOperation("UGCEndpoint.complainItem", map: dto);
  }
}
