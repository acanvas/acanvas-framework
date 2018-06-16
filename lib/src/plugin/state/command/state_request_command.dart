part of acanvas_framework.state;

/**
 * @author Nils Doehring (nilsdoehring(gmail as at).com)
 */

class StateRequestCommand extends AbstractStateCommand {
  @override
  void execute([AcSignal event = null]) {
    super.execute(event);
    List urlData = event.data.split("?");
    StateVO stateVO = _stateModel.getStateVO(urlData[0].toLowerCase());

    if (stateVO != null) {
      if (_stateModel.currentScreen == null &&
          stateVO.substate == StateConstants.SUB_MODAL) {
        // 0. nullToModal
        new AcSignal(StateEvents.ADDRESS_SET, "/").dispatch();
        return;
      }

      if (urlData.length > 1) {
        Map<String, String> params = {};
        List<String> list = (urlData[1] as String).split("&");
        list.forEach((String s) {
          List split = s.split("=");
          if (split.length > 1) {
            params[split[0]] = split[1];
          }
        });

        if (stateVO.params != null) {
          if (params.toString() != stateVO.params.toString())
            stateVO.params = params;
        } else {
          stateVO.params = params;
        }
      } else {
        stateVO.params = null;
      }

      new AcSignal(StateEvents.STATE_VO_SET, stateVO, dispatchCompleteEvent)
          .dispatch();
    } else {
      //If url not found in registry, default to root
      new AcSignal(StateEvents.ADDRESS_SET, "/", dispatchCompleteEvent)
          .dispatch();
    }
  }
}
