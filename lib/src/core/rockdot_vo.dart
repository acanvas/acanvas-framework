part of rockdot_dart;

class RockdotVO {
  RockdotVO([dynamic object = null]) {

    InstanceMirror thisVO = reflect(this);
    ClassMirror thisType = thisVO.type;
    
    /* Constructor param probably from JSON.toMap() */
    if (object is Map) {

      thisType.declarations.forEach((Symbol symbol, DeclarationMirror member) {

        if (member != null && object.containsKey(MirrorSystem.getName(symbol))) {
          dynamic thatValue = object[MirrorSystem.getName(symbol)];

          //type safety, the hard way. i don't care.
          try {
            thisVO.setField(symbol, thatValue);
          } catch (e) {
            try {
              thisVO.setField(symbol, int.parse(thatValue));
            } catch (e) {
              //no String, no int, what else would you need?
            }
          }
        } else {
          // value wasn't there, do something?
        }
      });

      return;

    }

    /* Constructor param probably from another Object extending RockdotVO */
    InstanceMirror thatVO = reflect(object);
    ClassMirror thatType = thatVO.type;

    thisType.declarations.forEach((Symbol symbol, DeclarationMirror member) {

      if (member != null && thatType.instanceMembers.containsKey(symbol)) {
        var thatValue = thatType.getField(symbol).reflectee;
        thisVO.setField(symbol, thatValue);
        // value was there.
      } else {
        // value wasn't there.
      }

    });
  }

  Map toMap() {
    Map map = new Map();

    InstanceMirror thisVO = reflect(this);
    ClassMirror thisType = thisVO.type;

    thisType.declarations.forEach((Symbol symbol, DeclarationMirror member) {
      if (member != null && member is VariableMirror/* && !member.isConst */ && !member.isStatic) {
        var thisValue = thisVO.getField(symbol).reflectee;
        map[MirrorSystem.getName(member.simpleName)] = thisValue;
      }
    });

    return map;
  }
}
