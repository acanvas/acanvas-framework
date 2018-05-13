## Rockdot framework for StageXL

Rockdot Dart is based on [Rockdot Actionscript Framework](https://github.com/block-forest/rockdot), which has been in continuous development for several years,
and was used in dozens of highly interactive rich media projects (marketing) for clients such as Mercedes-Benz, Nike, and Nikon, serving millions of users.

### Examples

* [Full Framework Demo](http://rockdot.sounddesignz.com/template/) - Generated with [Rockdot CLI](https://github.com/block-forest/rockdot-generator)
* [DartBook](http://rockdot.sounddesignz.com/dartbook/) - [Source](https://github.com/nilsdoehring/dartbook)
* [Box2D](http://rockdot.sounddesignz.com/box2d/) - [Source](https://github.com/block-forest/rockdot-physics/tree/master/lib/src/Examples)
* [BabylonJS StageXL Wrapper](http://rockdot.sounddesignz.com/dart/babylonjs-interop/) - [Source](https://github.com/block-forest/babylonjs-dart-facade/tree/master/example)
* [THREE.js StageXL Wrapper](http://rockdot.sounddesignz.com/dart/threejs-interop/) - [Source](https://github.com/block-forest/threejs-dart-facade/tree/master/example)
* [Material Design - Buttons (Commons only, just 92 KiB!)](http://rockdot.sounddesignz.com/stagexl-commons/paper_buttons.html) - [Source](https://github.com/block-forest/rockdot-commons/blob/master/web/material_buttons.dart)
* [Material Design - Controls (Commons only)](http://rockdot.sounddesignz.com/stagexl-commons/paper_radio.html) - [Source](https://github.com/block-forest/rockdot-commons/blob/master/web/material_radio.dart)
* [Material Design - Input (Commons only)](http://rockdot.sounddesignz.com/stagexl-commons/paper_input.html) - [Source](https://github.com/block-forest/rockdot-commons/blob/master/web/material_input.dart)

### Rockdot Framework is built upon
* [Rockdot Spring](https://github.com/block-forest/rockdot-spring) IoC container (ObjectFactory, ObjectFactory and Object Postprocessing, Interface Injection)
* [Rockdot Commons](https://github.com/block-forest/rockdot-commons) Async library (FrontController and Commands/Operations, also sequences)
* [Rockdot Commons](https://github.com/block-forest/rockdot-commons) EventBus (with some tweaks to Operations to make them as effective as Signals)
* [Rockdot Commons](https://github.com/block-forest/rockdot-commons) Logging
* [StageXL](https://github.com/bp74/StageXL) - Flash API for Dart

### Rockdot features
* Plugin system making use of all of the above
* Mature UI lifecycle management
* Asset load management (porting in progress)
* Generic User Generated Content backend communication (porting in progress. reading does work.)
* i18n
* Focus on highly interactive rich media applications
* LOTS of examples