part of stagexl_rockdot;

@retain
class UGCRateCommand extends AbstractUGCCommand {

  @override void execute([XLSignal event = null]) {
    super.execute(event);

    UGCRatingVO vo = event.data;
    String uid = _ugcModel.userDAO.uid;

    Map dto = {
      'id': vo.id,
      'rating': vo.rating,
      'uid': uid
    };

    amfOperation("UGCEndpoint.rateItem", map: dto);
  }
}
