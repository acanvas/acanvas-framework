part of stagexl_rockdot;


/**
 * A Dispatcher is initialized with a class instance and will dispatch methods of that class.
 * 
 * Dispatcher.dispatch("someMethod") will return a Future of whatever value  it returns.
 * 
 * It's mainly a wrapper around reflect. 
 * 
 * For any method dispatched, It returns either the return value of the method or instances of one
 * of three "Exception" classes. Most errors will be corralled into these objects, so that
 * runtime exceptions don't get thrown, instead returned in an orderly manner.
 * 
 *  
 */



symbolizeKeys(namedParams) {
  Map symbolMap = {};
  for (var key in namedParams.keys) {
    symbolMap[new Symbol(key)] = namedParams[key];
  }
  return symbolMap;
}

getMethodMirror(instanceMirror, methodName) {
  //InstanceMirror instanceMirror = reflect(instance);
  ClassMirror classMirror = instanceMirror.type;
  //Symbol sym = new Symbol(methodName);
  for (var classMember in classMirror.declarations.keys) {
    String instanceMethod = MirrorSystem.getName(classMember);
    if (instanceMethod == methodName) {
      var methodMirror = classMirror.declarations[classMember];
      if (methodMirror is! MethodMirror || methodMirror.isPrivate) return null;
      return classMember;
    }
  }
  return null;
}

class Dispatcher {
  var instance;
  Dispatcher(this.instance);

  dispatch(methodName, [positionalParams = null, namedParams = null]) {

    namedParams = namedParams == null ? {} : namedParams;
    positionalParams = positionalParams == null ? [] : positionalParams;

    if (!namedParams.isEmpty) namedParams = symbolizeKeys(namedParams);

    InstanceMirror instanceMirror = reflect(instance);
    var methodMirror = getMethodMirror(instanceMirror, methodName);
    if (methodMirror == null) {
      return new Future.sync(() {return new MethodNotFound("Method not found: $methodName");});
      //return new MethodNotFound("Method not found: $methodName");
    }
    return new Future.sync(() {
      InstanceMirror t;
      try {
        t = instanceMirror.invoke(methodMirror, positionalParams, namedParams);
      } on TypeError catch (e) {
        return new InvalidParameters('$e');
      } on NoSuchMethodError catch (e) {
        return new InvalidParameters('$e');
      } catch (e) {
        if (e is RuntimeException){
          return e;
        }
        return new RuntimeException(e);
      }
      return t.reflectee;
    });


  }
}
