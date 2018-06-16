part of acanvas_framework.state;

/**
 * @author Nils Doehring (nilsdoehring(gmail as at).com)
 */
class StateVO implements IAcVO {
  String view_id;

  String _propertyKey;

  void set propertyKey(String p) {
    _propertyKey = p;
  }

  String get propertyKey {
    return _propertyKey == null ? view_id : _propertyKey;
  }

  String substate;
  int tree_order;
  int tree_parent;

  String url;
  String label;
  String title;
  Map<String, String> params;
  String transition;

  StateVO() {}
}
