part of stagexl_rockdot.core;


const String JSONRPC2 = '2.0';
const String JSONRPC1 = '1.0';
//ContentType JSON_RPC_CONTENT_TYPE = new ContentType('application', 'json', charset: "utf-8");


class Notification {
}


class MethodRequest {
  var request;

  MethodRequest(this.request);

  get version {
    try {
      String version = request['jsonrpc'];
      if (version == null) return JSONRPC1;
      if (version != JSONRPC2) {
        throwerr(new RpcException('Invalid Request', -32600));
      }
      return version;
    } catch (e) {
      // we always get version first, so if request is not proper, fail here
      throw makeExceptionMap(new RpcException('Invalid Request', -32600), JSONRPC2, null);
    }
  }

  get method {
    var method = request['method'];
    if (method is! String) {
      throwerr(new RpcException('Invalid Request', -32600));
    }
    return method;
  }

  get namedParams {
    var params = request['params'];
    if (params is Map) return params;
    return null;
  }

  get positionalParams {
    var params = request['params'];
    if (params is List) return params;
    return null;
  }

  get id {
    var id = request['id'];
    if (id is String || id is num || id == null) {
      return id;
    }
    throwerr(new RpcException('Invalid Request', -32600));
  }

  throwerr(exception) {
    throw makeExceptionMap(exception, version, request['id']);
  }

}
/* Given a parsed JSON-RPC request and an instance with methods,
 * return a Future with a Map of the result of the instance's method or a
 * Notification object 
 */
jsonRpcDispatch(request, instance) {
  try {
    var rq = new MethodRequest(request);
    var version = rq.version;
    var id = rq.id;
    var method = rq.method;

    return new Future.sync(() => new Dispatcher(instance).dispatch(method, rq.positionalParams, rq.namedParams)).then((value) {

      if (id == null) {
        return new Notification();
      }

      if (value is RpcException) {
//        _logger.fine('$value');
        return makeExceptionMap(value, version, id);
      }

      Map resp = {
        'result': value,
        'id': id
      };
      if (version == JSONRPC2) {
        resp['jsonrpc'] = version;
      }
      if (version == JSONRPC1) {
        resp['error'] = null;
      }
      return resp;
    }).catchError((e) {
//      _logger.fine('$e');
      return makeExceptionMap(e, version, id);
    });
  } catch (e) {
    _logger.fine('$e');
    return new Future.sync(() => e);
  }
}

makeExceptionMap(anException, version, [id = null]) {
  Map resp = {
    'id': id
  };
  if (version == JSONRPC1) {
    resp['result'] = null;
  } else {
    resp['jsonrpc'] = version;
  }
  resp['error'] = {
    'code': anException.code,
    'message': anException.message
  };
  return resp;
}

_shouldBatch(obj) {
//  _logger.fine('checking batch');
  return obj is List && obj.length > 0;
}

/* Given a JSON-RPC-formatted request string and an instance,
 * return a Future containing a JSON-RPC-formatted response string or null.
 * Null means that nothing should be returned, though some transports must return something.
*/
jsonRpc(String request, Object instance) {
  //_logger.fine(request);
  try {
    var parsed = parseJson(request);
    return jsonRpcExec(parsed, instance).then((resp) => encodeResponse(resp));
  } on RpcException catch (e) {
    return new Future.sync(() => encodeResponse(makeExceptionMap(e, JSONRPC2)));
  }
}

/*  Given a proper parsed JSON-RPC Map or a List return the proper JSON-RPC Map or List of responses, 
 *  or a Notification object. The transport will decide how to encode into JSON and UTF-8 for delivery.
 *  Depending on transport, Notification objects may not need 
 *  to be delivered.
*/
jsonRpcExec(request, Object instance) {
  if (request is Map && (request['jsonrpc'] == JSONRPC2 || request['jsonrpc'] == null)) {
    _logger.fine('$request');
    return jsonRpcDispatch(request, instance);
  } else {
    if (_shouldBatch(request)) {
      var responses = [];
      for (var rpc in request) {
        if (rpc is Map) {
          rpc['jsonrpc'] = JSONRPC2;
        }
        _logger.fine('in batch: $rpc');
        var value = jsonRpcDispatch(rpc, instance);
        responses.add(new Future(() => value));
      }
      return Future.wait(responses).then((theList) {
        List output = [];
        for (var item in theList) {
          if (item is! Notification) {
            output.add(item);
          }
        }
        if (output.length > 0) {
          return output;
        }
        return new Notification();
      });
    }
    return new Future.sync(() => makeExceptionMap(new RpcException("Invalid request", -32600), "2.0", null));
  }
}

parseJson(aString) {
  try {
    var data = JSON.decode(aString);
    return data;
  } catch (e) {
    throw new RpcException("Parse error", -32700);
  }
}

encodeResponse(response) {
  if (response is Notification) {
    return null;
  }
  return JSON.encode(response);
}
