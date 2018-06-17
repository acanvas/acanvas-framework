# Acanvas Framework

*Acanvas Framework – for Dart 2.0 and StageXL.*

*Acanvas Framework* is part of a layered architecture [(diagram)](http://acanvas.sounddesignz.com/template/assets/home/acanvas_spring_architecture.png) originally conceived for [Actionscript](https://github.com/acanvas/acanvas-actionscript-framework),
and has been used in dozens of highly interactive rich media projects (marketing) for clients such as Mercedes-Benz, Nike, and Nikon, serving millions of users.

Build your own *Acanvas* project now – with *[Acanvas Generator](https://github.com/acanvas/acanvas-generator)*!
* Blazing fast IoC/DI/MVC UI framework for WebGL and Canvas2D, written in Dart.
* Write web apps, games, or both, in pure Dart. No HTML, no CSS, no JS.

### Features

* *Plugin System* – Create bundles of Models, Views, Commands, Assets, and Properties. 
* *UI Lifecycle* – Efficient management of Views and Transitions.
* *Loading* – Managed loading of Assets.
* *User Generated Content* – Generic Database and Services for Social Logins, User Management, Entries that can be liked and rated, Blacklisting, and Leaderboards. *WIP*.
* *Properties* – Get i18n, l10n, and Configuration, out-of-the-box.
* *Made for Speed* – Made for highly interactive rich media applications. *Performance WIP*.

### Examples

* The [Acanvas Framework Demo](http://acanvas.sounddesignz.com/acanvas-framework/) – Examples including Animation, Material Design, BitmapFonts, Toolchains (DragonBones, GAF, Spine), Physics, 3D, Bitmapdrawing.
* The best way to learn how to use *Acanvas Spring* and *Acanvas Framework* by generating a project with [Acanvas Generator](https://github.com/acanvas/acanvas-generator).
* [Acanvas Dartbook](http://acanvas.sounddesignz.com/acanvas-dartbook/) - [Source](https://github.com/acanvas/acanvas-dartbook)
* [Acanvas Physics](http://acanvas.sounddesignz.com/acanvas-physics/) - [Source](https://github.com/blockforest/acanvas-physics/tree/master/lib/src/Examples)
* [BabylonJS StageXL Wrapper](http://acanvas.sounddesignz.com/stagexl/babylonjs-interop/) - [Source](https://github.com/acanvas/babylonjs-dart-facade/tree/master/example)
* [THREE.js StageXL Wrapper](http://acanvas.sounddesignz.com/stagexl/threejs-interop/) - [Source](https://github.com/acanvas/threejs-dart-facade/tree/master/example)


### Acanvas Framework – Layered Architecture

*Acanvas Framework* is part of a layered architecture built upon the following components. 

* [Acanvas Spring](https://github.com/acanvas/acanvas-spring) IoC container (ObjectFactory, Postprocessing, Interface Injection).
* [Acanvas Commons](https://github.com/acanvas/acanvas-commons) Async library (FrontController and Commands/Operations, also sequences).
* [Acanvas Commons](https://github.com/acanvas/acanvas-commons) EventBus (with some tweaks to Operations to make them as effective as Signals).
* [Acanvas Commons](https://github.com/acanvas/acanvas-commons) Logging.
* [StageXL](https://github.com/bp74/StageXL) - Flash display list API for Dart.
* Dart 2.0.

See also *Acanvas Framework [Architecture Diagram](http://acanvas.sounddesignz.com/template/assets/home/acanvas_spring_architecture.png)*
