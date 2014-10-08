part of stagexl_rockdot;


	 @retain
class UGCFilterItemCommand extends AbstractUGCCommand implements IStateModelAware {
		 StateModel _stateModel;
		void set stateModel(StateModel stateModel) {
			_stateModel = stateModel;
		}

		@override dynamic execute([RockdotEvent event=null])
		 {
			super.execute(event);


			UGCFilterVO vo = event.data;

			switch(vo.condition) {
				case UGCFilterVO.CONDITION_FRIENDS:
					vo.creator_uids = _ugcModel.friendsWithUGCItems;
					break;
				case UGCFilterVO.CONDITION_ME:
					vo.creator_uid = _ugcModel.userDAO.uid;
					break;
				case UGCFilterVO.CONDITION_UGC_ID:
					int id = (_stateModel.currentStateVO.params["id"]).toInt();
					vo.item_id = id;
					break;
				case UGCFilterVO.CONDITION_ALL:
					break;
				case UGCFilterVO.CONDITION_UID:
					break;
			}

			//TODO ??? delete?
//			if(event && event.data is String) {
//				vo.condition = event.data;
//			}

			amfOperation("UGCEndpoint.filterItems", [vo]);

			return null;
		}


	}

