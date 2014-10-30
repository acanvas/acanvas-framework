part of stagexl_rockdot;

@retain
class GamingSaveGameCommand extends AbstractUGCCommand {

  @override void execute([RockdotEvent event = null]) {
    super.execute(event);
    
    UGCGameVO vo = event.data;
    vo.uid = _ugcModel.userDAO.uid;

    amfOperation("GamingEndpoint.saveGame", vo.toMap());
  }

  @override bool dispatchCompleteEvent([dynamic result = null]) {
    return super.dispatchCompleteEvent();
  }
}
