part of stagexl_rockdot;

	/**
	 * @author nilsdoehring
	 */
	 class UGCTaskVO extends UGCItemContainerVO {

		 int category_id;
		 String task_key;

		//type: 0:text, 1:image, 2:video, 3:audio, 4:link
		 int type;

		//extras (assembled in AMF Endpoint via category_id relation)
		 String category_key;
	 UGCTaskVO([Object obj=null]) : super(obj){

		}
	}

