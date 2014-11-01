part of stagexl_rockdot;

@retain
class UGCDeleteCommand extends AbstractUGCCommand {

  @override void execute([XLSignal event = null]) {
    super.execute(event);

    Map dto = {
      'id': _ugcModel.currentItemDAO.id
    };

    amfOperation("UGCEndpoint.deleteItem", map: dto);
  }
}
