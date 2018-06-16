part of acanvas_framework.facebook;

//https://developers.facebook.com/docs/sharing/reference/share-dialog

class FBPromptShareCommand extends AbstractFBCommand {
  @override
  void execute([AcSignal event = null]) {
    super.execute(event);

    if (notLoggedIn(event)) return;

    VOFBShare vo = event.data;

    js.JsObject shareConfig;
    switch (vo.type) {
      case VOFBShare.TYPE_SHARE_OG:
        shareConfig = new js.JsObject.jsify({
          'method': 'share_open_graph',
          'action_type': 'og.likes',
          'action_properties': json.encode({
            'object': vo.contentlink,
            //https://developers.facebook.com/docs/opengraph/using-actions/v2.1#capabilities
            'image': vo.image,
            //https://developers.facebook.com/docs/opengraph/using-actions/v2.1#mentions
            'message': vo.message
          })
        });
        break;
      case VOFBShare.TYPE_SHARE:
      default:
        shareConfig =
            new js.JsObject.jsify({'method': 'share', 'href': vo.contentlink});
        break;
    }

    _fbModel.FB.callMethod("ui", [shareConfig, _handleResult]);

    showMessage(getProperty("message.facebook.share.waiting"),
        blur: true, type: StateMessageVO.TYPE_WAITING);
  }

  void _handleResult(js.JsObject response) {
    hideMessage();
    if (containsError(response)) return;
    dispatchCompleteEvent();
  }
}
