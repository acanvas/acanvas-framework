part of rockdot_framework.ugc;


class UGCTrackInviteCommand extends AbstractUGCCommand {
  @override
  void execute([RdSignal event = null]) {
    super.execute(event);

    Map dto;
    if (event.data is Map) {
      dto = event.data;
    } else {
      dto = {
        'uid': event.data.uid,
        'request': event.data.request,
        'data': event.data.data,
        'to_ids': event.data.to_ids
      };
    }

    amfOperation("UGCEndpoint.trackInvite", map: dto);
  }
}
