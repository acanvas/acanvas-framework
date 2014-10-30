part of stagexl_rockdot;

@retain
class UGCMailSendCommand extends AbstractUGCCommand {

  @override void execute([RockdotEvent event = null]) {
    super.execute(event);
    
    String sender = getProperty("email.confirm.sender").split(r"$sender").join(getProperty("project.host.email.sender"));
    
    String body = getProperty("email.confirm.body").split(r"$name").join(_ugcModel.userDAO.name);
    if (_ugcModel.userExtendedDAO.firstname != null && _ugcModel.userExtendedDAO.lastname != null) {
      body = getProperty("email.confirm.body").split(r"$name").join(_ugcModel.userExtendedDAO.firstname + " " + _ugcModel.userExtendedDAO.lastname);
    }
    body = body.split(r"$link").join(getProperty("project.host.email.confirm") + "?e=" + _ugcModel.userExtendedDAO.email + "&h=" + _ugcModel.userExtendedDAO.hash);

    Map dto = {
      'subject': getProperty("email.confirm.subject"),
      'sender': sender,
      'body': body,
      'hash': _ugcModel.userExtendedDAO.hash,
      'email': _ugcModel.userExtendedDAO.email
    };

    amfOperation("UGCEndpoint.sendMail", dto);
  }
}
