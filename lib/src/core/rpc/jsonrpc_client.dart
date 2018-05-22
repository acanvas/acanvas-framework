part of rockdot_framework.core;

/* basic usage:
 *    import "package:jsonrpc2/jsonrpc_client.dart"
 *
 *    var url = "http://somelocation";
 *    var proxy = new ServerProxy(url);
 *    Future request = proxy.call("someServerMethod", [arg1, arg2 ]);
 *    request.then((value){doSomethingWithValue(value);});
 *
 * Each arg must be representable in JSON.
 *
 * Exceptions on the remote end will throw RemoteException.
 *
 * Optionally you may set timeout.
 *
 *   var proxy = new ServerProxy(url);
 *   proxy.timeout=300;
 *
 * If timeout happens, TimeoutException is thrown, with the JSON-RPC request
 * message as payload.
 *
 */

final _logger = new Logger('JSON-RPC');

class ServerProxy {
  String url;
  int timeout = 0;
  String serverVersion = '2.0';

  ServerProxy(this.url);

  notify(method, [params = null]) {
    return call(method, params, true);
  }

  retry(package) {
    return call(package.method, package.args, package.notify);
  }

  call(method, [params = null, notify = false]) {
    /* Package and send the request.
     * Return the response
     */

    if (params == null) params = [];
    var package = new JsonRpcMethod(method, params,
        notify: notify, serverVersion: serverVersion);
    if (notify) {
      _executeRequest(package);
      return new Future(() => null);
    } else
      return _executeRequest(package)
          .then((rpcResponse) => handleResponse(rpcResponse));
  }

  _executeRequest(package) {
    //return a future with the JSON-RPC response
    html.HttpRequest request = new html.HttpRequest();
    request.open("POST", url, async: true);
    request.timeout = timeout;
    request.setRequestHeader('Content-Type', 'application/json; charset=UTF-8');
    var c = new Completer();
    request.onReadyStateChange.listen((_) {
      if (request.readyState == 4) {
        switch (request.status) {
          case 200:
            c.complete(request);
            break;

          case 204:
            c.complete(request);
            break;

          default:
            c.completeError(
                new HttpStatusError(request.statusText, request, package));
        }
      }
    });
    //Timeout
    request.onTimeout.listen((_) {
      //request.abort();
      c.completeError(
          new TimeoutException('JsonRpcRequest timed out', request, package));
    });

    // It's sent out utf-8 encoded. Without having to be told. Nice!
    request.send(json.encode(package));
    return c.future.then((request) => new Future(() {
          String body = request.responseText;
          if (request.status == 204 || body.isEmpty) {
            return null;
          } else {
            // print(body);
            body = body.replaceAllMapped(
                new RegExp(r'"(\d+)"'), (Match m) => m.group(1));
            return json.decode(body);
          }
        }));
  }

  handleResponse(response) {
    if (response.containsKey('error')) {
      return (new RemoteException(response['error']['message'],
          response['error']['code'], response['error']['data']));
    } else {
      return response['result'];
    }
  }

  checkError(response) {
    if (response is RemoteException) throw response;
    return response;
  }
}

class BatchServerProxy extends ServerProxy {
  BatchServerProxy(url) : super(url);

  var requests = [];
  var responses = {};
  var used_ids = {};

  call(method, [params = null, notify = false]) {
    /* Package and send the request.
     * Return a Future with the HttpRequest object
     */

    if (params == null) params = [];
    var package = new JsonRpcMethod(method, params,
        notify: notify, serverVersion: serverVersion);
    requests.add(package);
    if (!notify) {
      var c = new Completer();
      responses[package.id] = c;
      return c.future;
    }
  }

  send() {
    if (requests.length > 0) {
      Future future = _executeRequest(requests);
      requests = [];
      return future
          .then((resp) => new Future.sync(() => handleResponses(resp)));
    }
  }

  handleResponses(resps) {
    for (var resp in resps) {
      var value = handleResponse(resp);
      //if (value is Exception) throw value;
      var id = resp['id'];
      if (id != null) {
        responses[id].complete(value);
        responses.remove(id);
      } else {
        var error = resp['error'];
        _logger.warning(
            new RemoteException(error['message'], error['code'], error['data'])
                .toString());
      }
    }
    return null;
  }
}

class JsonRpcMethod {
  String method;
  var args;
  bool notify;
  var _id;
  String serverVersion;

  JsonRpcMethod(this.method, this.args,
      {this.notify: false, this.serverVersion: '2.0'});

  get id {
    if (notify) {
      return null;
    } else {
      if (_id == null) _id = this.hashCode;
      return _id;
    }
  }

  set id(var value) => _id = value;

  toJson() {
    Map map;
    switch (serverVersion) {
      case '2.0':
        map = {
          'jsonrpc': serverVersion,
          'method': method,
          'params': (args is List || args is Map) ? args : [args]
        };
        if (!notify) map['id'] = id;
        break;
      case '1.0':
        if (args is Map)
          throw new FormatException("Cannot use named params in JSON-RPC 1.0");
        map = {
          'method': method,
          'params': (args is List) ? args : [args],
          'id': id
        };
        break;
    }
    return map;
  }

  toString() => "JsonRpcMethod: ${toJson()}";
}

class RemoteException implements Exception {
  int code;
  String message;
  var data;

  RemoteException([this.message, this.code, this.data]);

  toString() => data != null
      ? "RemoteException $code '$message' Data:($data))"
      : "RemoteException $code: $message";
}

class HttpStatusError implements Exception {
  var message;
  var data;
  var request;

  HttpStatusError([this.message, this.request, this.data]);

  toString() => "$message";
}

class TimeoutException implements Exception {
  String message;
  var data;
  var request;

  TimeoutException([this.message, this.request, this.data]);

  toString() => "$message";
}
