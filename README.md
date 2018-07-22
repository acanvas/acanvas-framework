# Acanvas Framework

Write web apps, games, or something in-between, in pure Dart. 
No HTML, no CSS, no JS. 

![Acanvas Banner](http://acanvas.sounddesignz.com/acanvas-framework/assets/autoload/acanvas-logo-wide-bnw@2x.png)

*Acanvas Framework* is part of a layered architecture [(diagram)](https://acanvas.sounddesignz.com/downloads/acanvas-spring-architecture.png) originally conceived for [Actionscript](https://github.com/acanvas/acanvas-actionscript-framework),
and has been used in dozens of highly interactive microsites and facebook apps for brands such as Mercedes-Benz, Nike, Nikon, serving millions of pageviews.

Build your own *Acanvas* project now – with *[Acanvas Generator](https://github.com/acanvas/acanvas-generator)*.

## Acanvas Examples

* The [Acanvas Framework Demo](http://acanvas.sounddesignz.com/acanvas-framework/) – Examples including Animation, Material Design, BitmapFonts, Toolchains (DragonBones, GAF, Spine), Physics, 3D, Bitmapdrawing.
* The best way to learn how to use *Acanvas Spring* and *Acanvas Framework* by generating a project with [Acanvas Generator](https://github.com/acanvas/acanvas-generator).
* [Acanvas Dartbook](http://acanvas.sounddesignz.com/acanvas-dartbook/) - [Source](https://github.com/acanvas/acanvas-dartbook)
* [Acanvas Physics](http://acanvas.sounddesignz.com/acanvas-physics/) - [Source](https://github.com/blockforest/acanvas-physics/tree/master/lib/src/Examples)
* [BabylonJS StageXL Wrapper](http://acanvas.sounddesignz.com/stagexl/babylonjs-interop/) - [Source](https://github.com/acanvas/babylonjs-dart-facade/tree/master/example)
* [THREE.js StageXL Wrapper](http://acanvas.sounddesignz.com/stagexl/threejs-interop/) - [Source](https://github.com/acanvas/threejs-dart-facade/tree/master/example)

## Acanvas Features

* Pixel-precise control over the html *CanvasElement (2D and WebGL)* through StageXL, the Flash DisplayList API for HTML5, written in Dart.

* A blazing fast, industry proven *IoC/DI/MVC+Command UI framework* based on Spring ActionScript and optimized for Dart 2.0.

* Smart *UI lifecycle management* of views, elements, transitions, effects. 

* *Runtimes* for GAF (Flash Pro), Spine, DragonBones, Flump, babylonjs, and THREE.js (coming soon).

* Integration with *facebook, google APIs* (examples included!).

* *Plugin System* – Create bundles of Models, Views, Commands, Assets, and Properties. 

* *Controlled Loading* – Managed loading of Assets.

* *User Generated Content* – Generic Database and Services for Social Logins, User Management, Entries that can be liked and rated, Blacklisting, and Leaderboards. *coming soon*.

* *Smart Properties* – Get i18n, l10n, and Configuration, out-of-the-box.

## Why Acanvas?

*Best of breed. Built for speed.*

Acanvas loads extra fast. The minified/gzipped JS comes at a mere 120 KByte, including Material Design UI components. Their underlying UI components were built years ago by some of the best ActionScript programmers in the field, resulting in snappy performance. And acceptable performance even on an 8 year old iPhone 4. Acanvas generally animates at 60 fps, but has an idle mode to save on cpu load and battery whenever possible.

*Innovation.*

Acanvas takes technology out of the way, so that teams can focus on UX and jaw dropping designs. Each generated project comes with CLI tools to collect assets and create pages and elements. And with full GAF, DragonBones, and Spine integration, you get a scalable designer-developer workflow out of the box!

*Total control.*

With Acanvas, you define what happens when - control every pixel and every millisecond, and make art direction happy. Because _everything_ is built in Dart, you get full cycle introspection from logic to layout and back again. No media breach. No magic functions. No WTFs. Too much marketing speak? I'm not even done yet:

*Extreme flexibility.*

Acanvas has been used for microsites, facebook apps, and mobile apps (Adobe AIR). Thanks to Spring's IoC container and smart conventions, you can plug everything together with everything else. No matter what, things won't get messy. You write Acanvas code once, and it runs anywhere.

*Rapid scalability.*

An Acanvas project team usually only requires a single 'system architect', responsible for its bootstrap and creation of commands and services. All other developers can focus on the frontend and will feel at home, instantly. There have been cases where teams were scaled from one to six frontend developers without framework experience within a single day.

*Inherent reusability.*

How often did you hear yourself saying: "some time after the project is done, i will clean up and reuse this and that killer feature"? Exactly, too often. Acanvas's architecture enables you to code in a sustainable fashion without losing speed.

*Time to market.*

Much faster than traditional html/js/css. Not only will you have more certainty about what's feasible, but also way, way, way less QA.


## Acanvas Architecture

*Acanvas* is a layered architecture that consists of the following components. 

* [Acanvas Spring](https://github.com/acanvas/acanvas-spring) IoC container (ObjectFactory, Postprocessing, Interface Injection).
* [Acanvas Commons](https://github.com/acanvas/acanvas-commons) Async library (FrontController and Commands/Operations, also sequences).
* [Acanvas Commons](https://github.com/acanvas/acanvas-commons) EventBus (with some tweaks to Operations to make them as effective as Signals).
* [Acanvas Commons](https://github.com/acanvas/acanvas-commons) Logging.
* [StageXL](https://github.com/bp74/StageXL) - Flash display list API for Dart.
* Dart 2.0.

See also *Acanvas Framework [Architecture Diagram](http://acanvas.sounddesignz.com/template/assets/home/acanvas_spring_architecture.png)*
