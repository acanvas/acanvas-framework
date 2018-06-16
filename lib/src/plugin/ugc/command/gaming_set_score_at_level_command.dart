part of acanvas_framework.ugc;

class GamingSetScoreAtLevelCommand extends AbstractUGCCommand {
  @override
  void execute([AcSignal event = null]) {
    super.execute(event);
    UGCGameDTO vo = event.data;
    vo.uid = _ugcModel.userDAO.uid;

    amfOperation("GamingEndpoint.setScore", dto: vo);
  }

  @override
  bool dispatchCompleteEvent([dynamic result = null]) {
    _ugcModel.userExtendedDAO.score = result.score;
    _ugcModel.gaming.rank = result.rank;
    return super.dispatchCompleteEvent(result);
  }
}
