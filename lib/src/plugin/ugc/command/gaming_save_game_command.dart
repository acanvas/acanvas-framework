part of stagexl_rockdot.ugc;

//@retain
class GamingSaveGameCommand extends AbstractUGCCommand {

  @override void execute([XLSignal event = null]) {
    super.execute(event);
    
    UGCGameDTO vo = event.data;
    vo.uid = _ugcModel.userDAO.uid;

    amfOperation("GamingEndpoint.saveGame", dto: vo);
  }

  @override bool dispatchCompleteEvent([dynamic result = null]) {
    return super.dispatchCompleteEvent();
  }
}
