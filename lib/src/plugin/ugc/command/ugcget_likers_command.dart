part of stagexl_rockdot;

@retain
class UGCGetLikersCommand extends AbstractUGCCommand {

  @override void execute([RockdotEvent event = null]) {
    super.execute(event);

    int currentImageID = (_ugcModel.currentItemDAO.id).toInt();
    UGCFilterVO vo = event.data;

    Map dto = {
      'id': currentImageID,
      'limitIndex': vo.limitindex,
      'limit': vo.limit
    };

    amfOperation("UGCEndpoint.getLikersOfItem", dto);
  }

  @override bool dispatchCompleteEvent([dynamic event = null]) {
    _ugcModel.currentItemDAO.likers = event.result;
    return super.dispatchCompleteEvent(event.result);
  }
}
