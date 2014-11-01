part of stagexl_rockdot;



	/**
	 * @author nilsdoehring
	 */
	 class DataProxy implements IDataProxy{
		
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

		UGCFilterVO _dataFilterVO; 
		void set dataFilterVO(UGCFilterVO dataFilterVO) {
			_dataFilterVO = dataFilterVO;
		} 
		UGCFilterVO get dataFilterVO { 
			return _dataFilterVO;
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
		}
	 DataProxy() {
			_dataFilterVO;
			reset();
		} void reset()
		 {
			_dataTotalSize = 0;
			_dataCache = [];
			_dataPageSize = 100;
			_cursor = 0;
		} int hasChunk(int chunkIndex,int chunkSize)
		 {
			
			if(chunkIndex<0){
				return 0;
			}
			if(chunkIndex < _dataTotalSize){
				if(chunkIndex + chunkSize < _dataTotalSize){
					return chunkSize;
				}
				else{
					return _dataTotalSize - chunkIndex;
				}
			}
			return 0;
		} void requestChunk(Function callBack,[int chunkIndex=-1,int chunkSize=-1])
		 {
			_onDataCallback = callBack;
			
			if(chunkIndex == -1){
				callBack.call(null, _dataCache);
			}
			else if(chunkSize == -1){
				_chunkSize = chunkSize;
				_chunkIndex = chunkIndex;
				_dataRetrieveCommand.addCompleteListener(_onData);
				_dataRetrieveCommand.execute();
			}
			else if(chunkIndex < _cursor){
				 if(chunkIndex + chunkSize >= _cursor){
				 	chunkSize = _cursor - chunkIndex;
				 }
				_onDataCallback.call(_dataCache.getRange(chunkIndex, chunkIndex+chunkSize));
			}
			else{
				if(dataFilterVO.limit != false){
					dataFilterVO.limit = _dataPageSize;
				}
				if(dataFilterVO.limitindex != false){
				dataFilterVO.limitindex = _cursor;
				}				
				_cursor += _dataPageSize;

				_chunkIndex = chunkIndex;
				_chunkSize = chunkSize;
//				
				_dataRetrieveCommand.addCompleteListener(_onData);
				_dataRetrieveCommand.execute(new XLSignal("data", dataFilterVO));
			}
		} void _onData(OperationEvent event)
		 {
			_dataRetrieveCommand.removeCompleteListener(_onData);
			if(event.operation.result.length == 0){
				_dataTotalSize = 0;
				_onDataCallback.call(this, event.operation.result);
			}
			else{
			  List res = event.result;
			  var json = res.elementAt(0); 
				if(res.elementAt(0)["totalrows"] != null){
					_dataTotalSize = res.elementAt(0)["totalrows"];
					if(_cursor>_dataTotalSize){
						_cursor = _dataTotalSize;
					}
				}
				else{
					//_totalSize = event.result.length;
				}
				_dataCache.addAll( res);
				if(_chunkIndex != -1){
					_onDataCallback.call(_dataCache.getRange(_chunkIndex, min(_dataTotalSize, _chunkIndex+_chunkSize)));
				}
				else{
					_onDataCallback.call(_dataCache);
				}
			}
		}
	}

