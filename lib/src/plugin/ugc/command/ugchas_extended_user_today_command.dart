part of acanvas_framework.ugc;

class UGCHasExtendedUserTodayCommand extends AbstractUGCCommand {
  @override
  void execute([AcSignal event = null]) {
    super.execute(event);

    Map dto = {'uid': event.data ? event.data : _ugcModel.userDAO.uid};

    amfOperation("UGCEndpoint.hasUserExtendedToday", map: dto);
  }

  @override
  bool dispatchCompleteEvent([dynamic result = null]) {
    if (result == true) {
      _ugcModel.hasUserExtendedDAO = true;
    }
    return super.dispatchCompleteEvent(result);
  }
}
