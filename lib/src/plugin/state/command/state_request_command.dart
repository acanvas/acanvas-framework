part of stagexl_rockdot.state;

/**
	 * @author Nils Doehring (nilsdoehring(gmail as at).com)
	 */
//@retain
class StateRequestCommand extends AbstractStateCommand {

  @override void execute([XLSignal event = null]) {
    super.execute(event);
    List urlData = event.data.split("?");
    StateVO stateVO = _stateModel.getPageVO(urlData[0].toLowerCase());

    if (stateVO != null) {

      if (_stateModel.currentPage == null && stateVO.substate == StateConstants.SUB_MODAL) {
        // 0. nullToModal
        new XLSignal(StateEvents.ADDRESS_SET, "/").dispatch();
        return;
      }

      if (urlData.length > 1) {
        Map params = new Map();
        List list = (urlData[1] as String).split("&");
        list.forEach((String s) {
          List split = s.split("=");
          if (split.length > 1) {
            params[split[0]] = split[1];
          }
        });

        if (stateVO.params != null) {
          if (params.toString() != stateVO.params.toString()) stateVO.params = params;
        } else {
          stateVO.params = params;
        }
      } else {
        stateVO.params = null;
      }

      new XLSignal(StateEvents.STATE_VO_SET, stateVO, dispatchCompleteEvent).dispatch();



    } else {
      // TODO: Define routine for unregistered urls.
      new XLSignal(StateEvents.ADDRESS_SET, "/", dispatchCompleteEvent).dispatch();
    }

  }
}
