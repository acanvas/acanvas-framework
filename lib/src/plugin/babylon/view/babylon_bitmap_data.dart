part of rockdot_framework.babylon;

class BabylonBitmapData extends BitmapData {
  BABYLON.Engine _babylonEngine;
  BABYLON.Scene _babylonScene;
  html.DivElement _container = new html.DivElement();
  Completer<BabylonBitmapData> _completer = new Completer<BabylonBitmapData>();

  BabylonBitmapData._internal(RenderTextureQuad quad)
      : super.fromRenderTextureQuad(quad);

  void dispose() {
    _babylonScene.dispose();
    _babylonEngine.stopRenderLoop(allowInterop(_onRender));
    renderTexture.dispose();
  }

  BABYLON.Engine get babylonEngine => _babylonEngine;
  BABYLON.Scene get babylonScene => _babylonScene;

  //----------------------------------------------------------------------------

  static Future<BabylonBitmapData> load(
      String rootUrl, String sceneFilename, num width, num height,
      [num pixelRatio = 1.0]) {
    int textureWidth = (width * pixelRatio).round();
    int textureHeight = (height * pixelRatio).round();
    var renderTexture = new RenderTexture(textureWidth, textureHeight, 0);
    var renderTextureQuad = renderTexture.quad.withPixelRatio(pixelRatio);
    var instance = new BabylonBitmapData._internal(renderTextureQuad);

    instance._container.style.overflow = "hidden";
    instance._container.style.width = "0px";
    instance._container.style.height = "0px";
    instance._container.children.add(renderTexture.canvas);
    html.document.body.children.add(instance._container);

    instance._babylonEngine = new BABYLON.Engine(renderTexture.canvas, true);
    instance._babylonEngine.runRenderLoop(allowInterop(instance._onRender));

    // TODO: get rid of loading screen!
    // https://doc.babylonjs.com/tutorials/Creating_a_custom_loading_screen

    BABYLON.SceneLoader.Load(
        rootUrl,
        sceneFilename,
        instance._babylonEngine,
        allowInterop(instance._onSuccess),
        allowInterop(instance._onProgress),
        allowInterop(instance._onError));

    return instance._completer.future;
  }

  //----------------------------------------------------------------------------

  void _onRender() {
    _babylonScene?.render();
    renderTexture.update();
  }

  void _onSuccess(BABYLON.Scene newScene) {
    _babylonScene = newScene;
    _babylonScene
        .executeWhenReady(allowInterop(() => _completer.complete(this)));
  }

  void _onProgress(dynamic evt) {}

  void _onError(BABYLON.Scene a) {}
}
