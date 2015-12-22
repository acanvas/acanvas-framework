part of rockdot_framework.core;

class RpcException implements Exception {
  int code = 0;
  String message;

  RpcException([this.message, this.code]);

  toString() {
    return this.message;
  }
}

class MethodNotFound extends RpcException {
  MethodNotFound([message = '', code = -32601]) {
    this.message = message;
    this.code = code;
  }
}

class InvalidParameters extends RpcException {
  InvalidParameters([message = '', code = -32602]) {
    this.message = message;
    this.code = -32602;
  }
}

class RuntimeException extends RpcException {
  var error;

  RuntimeException([message = '', code = -32603]) {
    if (message is Exception) {
      this.error = message;
      this.message = error.message;

    }
    else if (message is Error) {
      this.error = message;
      this.message = "$message";
    }

    else {
      this.message = message;

    }
    this.code = code;
  }
}
