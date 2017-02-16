part of rockdot_framework.io;

/**
 * @author nilsdoehring
 * Yes, this class is an undocumented mess.
 */
class DataProxy implements IDataProxy {
  int _dataPageSize;

  int _cursor;
  int _chunkIndex;
  int _chunkSize;

  List _dataCache;

  void set dataCache(List dataCache) {
    _dataCache = dataCache;
  }

  List get dataCache {
    return _dataCache;
  }

  DataRetrieveVO _dataRetrieveCommandVO;

  void set dataRetrieveCommandVO(DataRetrieveVO dataRetrieveCommandVO) {
    _dataRetrieveCommandVO = dataRetrieveCommandVO;
    reset();
  }

  DataRetrieveVO get dataRetrieveCommandVO {
    return _dataRetrieveCommandVO;
  }

  int _dataTotalSize;

  void set dataTotalSize(int dataTotalSize) {
    _dataTotalSize = dataTotalSize;
  }

  int get dataTotalSize {
    return _dataTotalSize;
  }

  Function _onDataCallback;

  void set onDataCallback(Function onDataCallback) {
    _onDataCallback = onDataCallback;
  }

  IAsyncCommand _dataRetrieveCommand;

  void set dataRetrieveCommand(IAsyncCommand dataRetrieveCommand) {
    _dataRetrieveCommand = dataRetrieveCommand;
    reset();
  }

  DataProxy() {
    reset();
  }

  void reset() {
    _dataTotalSize = 0;
    _dataCache = [];
    _dataPageSize = 100;
    _cursor = 0;
  }

  int hasChunk(int chunkIndex, int chunkSize) {
    if (chunkIndex < 0) {
      return 0;
    }
    if (chunkIndex < _dataTotalSize) {
      if (chunkIndex + chunkSize < _dataTotalSize) {
        return chunkSize;
      } else {
        return _dataTotalSize - chunkIndex;
      }
    }
    return 0;
  }

  void requestChunk(Function callBack, [int chunkIndex = -1, int chunkSize = -1]) {
    _onDataCallback = callBack;

    /* Special case: If the chunkIndex is set to -1, all data must be in our internal Cache */
    if (chunkIndex == -1) {
      callBack.call(null, _dataCache);
    }
    /* Special case: If the chunkSize is set to -1, our dataRetrieveCommand doesn't support paging */
    else if (chunkSize == -1) {
      _chunkSize = chunkSize;
      _chunkIndex = chunkIndex;
      _dataRetrieveCommand.addCompleteListener(onData);
      _dataRetrieveCommand.execute();
    }
    /* Is the start of the requested data range below the current theoretical maximum of loaded datasets? */
    else if (chunkIndex < _cursor) {
      /* Is the end of the requested data range above the current theoretical maximum of loaded datasets? */
      if (chunkIndex + chunkSize >= _cursor) {
        /* Is the end of the requested data range below the actual maximum of available datasets? */
        if (chunkIndex + chunkSize <= _dataTotalSize) {
          //request the data via our dataRetrieveCommand
          _requestChunkExecute(callBack, chunkIndex, chunkSize);
          return;
        }

        //cut the end of the requested data range to the actual maximum of available datasets
        chunkSize = (_cursor < _dataTotalSize ? _cursor : _dataTotalSize) - chunkIndex;
      }
      //request data from internal Cache
      _onDataCallback
          .call(new List.from(_dataCache.getRange(chunkIndex, math.min(dataTotalSize, chunkIndex + chunkSize))));
    } else {
      //request the data via our dataRetrieveCommand
      _requestChunkExecute(callBack, chunkIndex, chunkSize);
    }
  }

  void _requestChunkExecute(Function callBack, int chunkIndex, int chunkSize) {
    if (dataRetrieveCommandVO.limit == null) {
      dataRetrieveCommandVO.limit = _dataPageSize;
    }
    /* Only set the nextToken to our current loaded size if it has not been set otherwise (i.e. inside our dataRetrieveCommand) */
    if (dataRetrieveCommandVO.nextToken == null) {
      dataRetrieveCommandVO.nextToken = _cursor.toString();
    }
    _cursor += _dataPageSize;

    _chunkIndex = chunkIndex;
    _chunkSize = chunkSize;
    //
    _dataRetrieveCommand.addCompleteListener(onData);
    _dataRetrieveCommand.execute(new RdSignal("data", dataRetrieveCommandVO));
  }

  void onData(OperationEvent event) {
    _dataRetrieveCommand.removeCompleteListener(onData);

    /* No data */
    if (event.operation.result.length == 0) {
      _dataTotalSize = 0;
      _onDataCallback.call(this, event.operation.result);
    } else {
      List res = event.result;
      var json = res.elementAt(0);
      /* Retrieve _dataTotalSize from "totalRows" attribute in first Element of List (this is how rockdot-framework-zend backend handles this) */
      if (res.elementAt(0) is Map && res.elementAt(0)["totalrows"] != null) {
        _dataTotalSize = res.elementAt(0)["totalrows"];

        if (_cursor > _dataTotalSize) {
          _cursor = _dataTotalSize;
        }
      }
      /* Retrieve _dataTotalSize from VO (has been set inside dataRetrieveCommand) */
      else if (_dataRetrieveCommandVO.totalSize != null) {
        _dataTotalSize = _dataRetrieveCommandVO.totalSize;
      }
      _dataCache.addAll(res);

      /* Now that our Cache has been filled, send it's data to the callback */
      if (_chunkIndex != -1) {
        int chunkSize =
            _dataTotalSize == 0 ? _chunkIndex + _chunkSize : math.min(_dataTotalSize, _chunkIndex + _chunkSize);
        _onDataCallback.call(new List.from(_dataCache.getRange(_chunkIndex, chunkSize)));
      } else {
        _onDataCallback.call(_dataCache);
      }
    }
  }
}
