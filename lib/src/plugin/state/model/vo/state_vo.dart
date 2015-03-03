part of stagexl_rockdot.state;

/**
	 * @author Nils Doehring (nilsdoehring(gmail as at).com)
	 */
class StateVO implements IXLVO {
  String view_id;

  String _property_key;
  void set property_key(String p) {
    _property_key = p;
  }
  String get property_key {
    return property_key == null ? view_id : property_key;
  }

  String substate;
  int tree_order;
  int tree_parent;

  String url;
  String label;
  String title;
  Map params;
  String transition;

  StateVO() {
  }

}
