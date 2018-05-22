part of rockdot_framework.state;

/**
 * @author Nils Doehring (nilsdoehring(gmail as at).com)
 */

class StateModel extends MApplicationContextAware {
  final Logger _log = new Logger("StateModel");

  IAddressService _addressService;

  IAddressService get addressService {
    return _addressService;
  }

  void set addressService(IAddressService navigationProxy) {
    _addressService = navigationProxy;
  }

  List _history;

  List get history {
    return _history;
  }

  void set history(List history) {
    _history = history;
  }

  int _historyCount = -1;

  int get historyCount {
    return _historyCount;
  }

  void set historyCount(int historyCount) {
    _historyCount = historyCount;
  }

  String _currentState;

  String get currentState {
    return _currentState;
  }

  void set currentState(String currentState) {
    _currentState = currentState;
  }

  LifecycleSprite _currentScreen;

  LifecycleSprite get currentScreen {
    return _currentScreen;
  }

  void set currentScreen(LifecycleSprite currentScreen) {
    _currentScreen = currentScreen;
  }

  Map _stateVOMap = new Map();

  Map get pageVOs {
    return _stateVOMap;
  }

  StateVO _currentStateVO;

  StateVO get currentStateVO {
    return _currentStateVO;
  }

  void set currentStateVO(StateVO pageVO) {
    _currentStateVO = pageVO;
  }

  Map<String, String> _currentStateURLParams;

  Map<String, String> get currentStateURLParams {
    return _currentStateURLParams;
  }

  void set currentStateURLParams(Map<String, String> stateVOParams) {
    _currentStateURLParams = stateVOParams;
  }

  LifecycleSprite _modalizedScreen;

  LifecycleSprite get modalizedScreen {
    return _modalizedScreen;
  }

  void set modalizedScreen(LifecycleSprite modalizedPage) {
    _modalizedScreen = modalizedPage;
  }

  IEffect _currentTransition;

  IEffect get currentTransition {
    return _currentTransition;
  }

  void set currentTransition(IEffect currentTransition) {
    _currentTransition = currentTransition;
  }

  CompositeCommandWithEvent _compositeTransitionCommand;

  CompositeCommandWithEvent get compositeTransitionCommand {
    return _compositeTransitionCommand;
  }

  void set compositeTransitionCommand(
      CompositeCommandWithEvent compositeTransitionCommand) {
    _compositeTransitionCommand = compositeTransitionCommand;
  }

  CompositeCommandWithEvent _compositeEffectCommand;

  CompositeCommandWithEvent get compositeEffectCommand {
    return _compositeEffectCommand;
  }

  void set compositeEffectCommand(
      CompositeCommandWithEvent compositeEffectCommand) {
    _compositeEffectCommand = compositeEffectCommand;
  }

  StateModel() {
    _history = [];
    _stateVOMap = new Map();
  }

  void addStateVO(StateVO stateVO) {
    stateVO.label = getProperty(stateVO.view_id + ".label", true);
    stateVO.title = getProperty(stateVO.view_id + ".title", true);
    if (stateVO.url == null) {
      stateVO.url = getProperty(stateVO.view_id + ".url", true);
    }
    String voKey = stateVO.url.toLowerCase();
    _stateVOMap[voKey] = stateVO;
    _log.info("Registered URL: " + voKey);
  }

  List<StateVO> getStateVOList([bool sort = true, int tree_parent = 0]) {
    List<StateVO> stateVOList = new List<StateVO>.from(_stateVOMap.values
        .toList()
        .where((stateVO) => stateVO.tree_parent == tree_parent));
    //_stateVOMap.values.toList().where((stateVO) => stateVO.tree_parent == tree_parent).toList() as List<StateVO>;

    if (sort) {
      stateVOList.sort((StateVO voa, StateVO vob) {
        if (voa.tree_order > vob.tree_order) {
          return 1;
        } else if (voa.tree_order < vob.tree_order) {
          return -1;
        } else {
          return 0;
        }
      });
    }

    return stateVOList;
  }

  StateVO getStateVO(String url) {
    return _stateVOMap[url.toLowerCase()];
  }
}
