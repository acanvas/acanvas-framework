part of acanvas_framework.ugc;

class UGCDeleteCommand extends AbstractUGCCommand {
  @override
  void execute([AcSignal event = null]) {
    super.execute(event);

    Map dto = {'id': _ugcModel.currentItemDAO.id};

    amfOperation("UGCEndpoint.deleteItem", map: dto);
  }
}
