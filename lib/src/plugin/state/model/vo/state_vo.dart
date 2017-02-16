part of rockdot_framework.state;

/**
 * @author Nils Doehring (nilsdoehring(gmail as at).com)
 */
class StateVO implements IRdVO {
  String view_id;

  String _propertyKey;

  void set propertyKey(String p) {
    _propertyKey = p;
  }

  String get propertyKey {
    return propertyKey == null ? view_id : propertyKey;
  }

  String substate;
  int tree_order;
  int tree_parent;

  String url;
  String label;
  String title;
  Map params;
  String transition;

  StateVO() {}
}
