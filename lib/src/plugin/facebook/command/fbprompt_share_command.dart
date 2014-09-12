 part of rockdot_dart;

	 @retain
class FBPromptShareCommand extends AbstractFBCommand {

		@override 
		  dynamic execute([RockdotEvent event=null]) {
			super.execute(event);
			VOFBShare vo = event.data;
			Object attachment = {
					'name': vo.title, 'href': vo.contentlink, 'description': vo.message, 'media': [{ 'type': 'image', 'src': vo.image, 'href': vo.contentlink}]
					}; 
			List action_links = [{'text': vo.actionText, 'href':vo.actionLink}];  
				
			//http://developers.facebook.com/docs/reference/dialogs
			Facebook.ui("stream.publish", {attachment : attachment, action_links:action_links}, null, "iframe");
			dispatchCompleteEvent();
		}
	}

