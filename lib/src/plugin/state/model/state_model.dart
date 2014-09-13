part of rockdot_dart;



/**
	 * @author Nils Doehring (nilsdoehring(gmail as at).com)
	 */

@retain
class StateModel implements IApplicationContextAware {

  final RockdotLogger _log = new RockdotLogger("StateModel");

  IApplicationContext _context;
  IApplicationContext get applicationContext {
    return _context;
  }
  void set applicationContext(IApplicationContext value) {
    _context = value;
  }

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

  String _currentSubState;
  String get currentSubState {
    return _currentSubState;
  }
  void set currentSubState(String currentSubState) {
    _currentSubState = currentSubState;
  }


  IManagedSpriteComponent _currentPage;
  IManagedSpriteComponent get currentPage {
    return _currentPage;
  }
  void set currentPage(IManagedSpriteComponent currentPage) {
    _currentPage = currentPage;
  }

  Map _pageVOs;
  Map get pageVOs {
    return _pageVOs;
  }

  StateVO _currentPageVO;
  StateVO get currentStateVO {
    return _currentPageVO;
  }
  void set currentStateVO(StateVO pageVO) {
    _currentPageVO = pageVO;
  }

  Object _currentPageVOParams;
  Object get currentPageVOParams {
    return _currentPageVOParams;
  }
  void set currentPageVOParams(Object pageVOParams) {
    _currentPageVOParams = pageVOParams;
  }


  IManagedSpriteComponent _modalizedPage;
  IManagedSpriteComponent get modalizedPage {
    return _modalizedPage;
  }
  void set modalizedPage(IManagedSpriteComponent modalizedPage) {
    _modalizedPage = modalizedPage;
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
  void set compositeTransitionCommand(CompositeCommandWithEvent compositeTransitionCommand) {
    _compositeTransitionCommand = compositeTransitionCommand;
  }
  CompositeCommandWithEvent _compositeEffectCommand;
  CompositeCommandWithEvent get compositeEffectCommand {
    return _compositeEffectCommand;
  }
  void set compositeEffectCommand(CompositeCommandWithEvent compositeEffectCommand) {
    _compositeEffectCommand = compositeEffectCommand;
  }
  StateModel() {
    _history = [];
    _pageVOs = new Map();
  }
  void addStateVO(StateVO pageVO) {
    pageVO.label = _context.propertiesProvider.getProperty(pageVO.view_id + ".label");
    pageVO.title = _context.propertiesProvider.getProperty(pageVO.view_id + ".title");
    if (pageVO.url == null) {
      pageVO.url = _context.propertiesProvider.getProperty(pageVO.view_id + ".url");
    }
    String voKey = pageVO.url.toLowerCase();
    _pageVOs[voKey] = pageVO;
    _log.info("Registered URL: " + voKey);
  }
  List getPageVOList([bool sort = true, int tree_parent = 0]) {
    List naviVOs = _pageVOs.values.toList();
    List arr = [];
    if (sort) {
      naviVOs.sort((StateVO voa, StateVO vob){ 
        if(voa.tree_order > vob.tree_order) return 1;
        else if(voa.tree_order < vob.tree_order) return -1;
        else return 0;
      });
    }
    for (int i = 0; i < naviVOs.length; i++) {
      if (naviVOs[i].tree_parent == tree_parent) {
        arr.add(naviVOs[i]);
      }
    }
    return arr;
  }
  StateVO getPageVO(String url) {
    return _pageVOs[url.toLowerCase()];
  }




}
