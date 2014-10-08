part of stagexl_rockdot;






	 @retain
class UGCTrackInviteCommand extends AbstractUGCCommand {

		@override dynamic execute([RockdotEvent event=null])
		 {
			super.execute(event);
			amfOperation("UGCEndpoint.trackInvite", event.data);
		}
	}

