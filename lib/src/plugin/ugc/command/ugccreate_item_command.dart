part of acanvas_framework.ugc;

class UGCCreateItemCommand extends AbstractUGCCommand {
  @override
  void execute([AcSignal event = null]) {
    super.execute(event);

    if (event.data is UGCItemDTO) {
      _ugcModel.currentItemDAO = event.data;
    }

    if (_ugcModel.currentItemDAO != null) {
      if (_ugcModel.currentItemContainerDAO != null &&
          _ugcModel.currentItemContainerDAO.id != null) {
        _ugcModel.currentItemDAO.container_id =
            _ugcModel.currentItemContainerDAO.id;
      }
      _ugcModel.currentItemDAO.creator_uid = _ugcModel.userDAO.uid;
      amfOperation("UGCEndpoint.createItem", dto: _ugcModel.currentItemDAO);
    } else {
      dispatchErrorEvent("Nothing to upload. Meh.");
    }
  }
}
