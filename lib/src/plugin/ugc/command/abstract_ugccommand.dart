part of stagexl_rockdot;


	 class AbstractUGCCommand extends CoreCommand implements IUGCModelAware{
		 UGCModel _ugcModel;
		void set ugcModel(UGCModel ugcModel) {
			_ugcModel = ugcModel;
		} void amfOperation(String string,[List args=null])
		 {
			IOperation operation = new PersistenceOperation(_ugcModel.service, string, args);
			operation.addCompleteListener(dispatchCompleteEvent);
			operation.addErrorListener(_handleError);
		}

		@override void _handleError(OperationEvent event)
		 {
			this.log.error(event.error);
			dispatchCompleteEvent(event.error);
		}
	}

