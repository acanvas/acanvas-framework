## Acanvas framework for StageXL

Acanvas Dart is based on [Acanvas Actionscript Framework](https://github.com/block-forest/acanvas), which has been in continuous development for several years,
and was used in dozens of highly interactive rich media projects (marketing) for clients such as Mercedes-Benz, Nike, and Nikon, serving millions of users.

[Architecture Diagram](http://acanvas.sounddesignz.com/template/assets/home/acanvas_spring_architecture.png).

### Examples

* [Full Framework Demo](http://acanvas.sounddesignz.com/template/) - Generated with [Acanvas CLI](https://github.com/block-forest/acanvas-generator)
* [DartBook](http://acanvas.sounddesignz.com/dartbook/) - [Source](https://github.com/nilsdoehring/dartbook)
* [Box2D](http://acanvas.sounddesignz.com/box2d/) - [Source](https://github.com/block-forest/acanvas-physics/tree/master/lib/src/Examples)
* [BabylonJS StageXL Wrapper](http://acanvas.sounddesignz.com/dart/babylonjs-interop/) - [Source](https://github.com/block-forest/babylonjs-dart-facade/tree/master/example)
* [THREE.js StageXL Wrapper](http://acanvas.sounddesignz.com/dart/threejs-interop/) - [Source](https://github.com/block-forest/threejs-dart-facade/tree/master/example)
* [Material Design - Buttons (Commons only, just 92 KiB!)](http://acanvas.sounddesignz.com/stagexl-commons/paper_buttons.html) - [Source](https://github.com/block-forest/acanvas-commons/blob/master/web/material_buttons.dart)
* [Material Design - Controls (Commons only)](http://acanvas.sounddesignz.com/stagexl-commons/paper_radio.html) - [Source](https://github.com/block-forest/acanvas-commons/blob/master/web/material_radio.dart)
* [Material Design - Input (Commons only)](http://acanvas.sounddesignz.com/stagexl-commons/paper_input.html) - [Source](https://github.com/block-forest/acanvas-commons/blob/master/web/material_input.dart)

### Acanvas Framework is built upon
* [Acanvas Spring](https://github.com/block-forest/acanvas-spring) IoC container (ObjectFactory, ObjectFactory and Object Postprocessing, Interface Injection)
* [Acanvas Commons](https://github.com/block-forest/acanvas-commons) Async library (FrontController and Commands/Operations, also sequences)
* [Acanvas Commons](https://github.com/block-forest/acanvas-commons) EventBus (with some tweaks to Operations to make them as effective as Signals)
* [Acanvas Commons](https://github.com/block-forest/acanvas-commons) Logging
* [StageXL](https://github.com/bp74/StageXL) - Flash API for Dart

### Acanvas features
* Plugin system making use of all of the above
* Mature UI lifecycle management
* Asset load management (porting in progress)
* Generic User Generated Content backend communication (porting in progress. reading does work.)
* i18n
* Focus on highly interactive rich media applications
* LOTS of examples