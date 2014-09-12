part of rockdot_dart;

	/**
	 * @author Nils Doehring (nilsdoehring(gmail as at).com)
	 */
@retain
class StateVO extends RockdotVO {
		 String view_id;
		 String property_key;
		 String substate;
		 int tree_order;
		 int tree_parent;

		 String url;
		 String label;
		 String title;
		 Map params;
		 String transition;
	 StateVO([dynamic object = null]):super(object){
			if(property_key == null){
				property_key = view_id;
			}
		}

	}

