part of rockdot_framework.ugc;

//@retain
class GamingSetScoreCommand extends AbstractUGCCommand {

  @override void execute([RdSignal event = null]) {
    super.execute(event);

    UGCGameDTO vo = event.data;
    vo.uid = _ugcModel.userDAO.uid;

    amfOperation("GamingEndpoint.setScore", dto: vo);
  }

  @override bool dispatchCompleteEvent([dynamic result = null]) {
    _ugcModel.userExtendedDAO.score = result.result.score;
    _ugcModel.gaming.rank = result.result.rank;
    return super.dispatchCompleteEvent(result.result);
  }
}
