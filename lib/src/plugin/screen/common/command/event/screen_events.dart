part of rockdot_framework.screen;

/**
 * @author Nils Doehring (nilsdoehring(gmail as at).com)
 */
class ScreenEvents {
  //expects nothing
  static const String INIT = "ScreenEvents.INIT";

  //expects either UIElement (OPTIONAL!) or uses _modelUI.currentPage
  //then calls element.setSize with stageWidth and Height.
  static const String RESIZE = "ScreenEvents.RESIZE";
}
