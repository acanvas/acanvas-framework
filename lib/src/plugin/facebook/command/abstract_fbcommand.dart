 part of stagexl_rockdot;

	 @retain
class AbstractFBCommand extends CoreCommand implements IFBModelAware {
		 FBModel _fbModel;
		  void set fbModel(FBModel fbModel) {
			_fbModel = fbModel;
		}

	}

