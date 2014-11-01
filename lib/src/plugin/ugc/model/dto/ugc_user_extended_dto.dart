part of stagexl_rockdot;

/**
	 * @author nilsdoehring
	 */
class UGCUserExtendedDTO implements IXLDTO {
  String uid;
  String hash;

  String birthday_date;
  String hometown_location;

  String title;

  String firstname;
  String lastname;
  String street;
  String additional;
  String city;
  String county;
  String country;

  String email;
  int email_confirmed = 0;

  num score = 0;

  int newsletter = 0;
  int rules = 0;

  String timestamp;

  UGCUserExtendedDTO([Map inputDTO = null]) {
    if (inputDTO != null) {
      uid = inputDTO["uid"];
      hash = inputDTO["hash"];
      birthday_date = inputDTO["birthday_date"];
      hometown_location = inputDTO["hometown_location"];
      title = inputDTO["title"];
      firstname = inputDTO["firstname"];
      lastname = inputDTO["lastname"];
      street = inputDTO["street"];
      additional = inputDTO["additional"];
      city = inputDTO["city"];
      county = inputDTO["county"];
      country = inputDTO["country"];
      email = inputDTO["email"];
      email_confirmed = inputDTO["email_confirmed"];
      score = inputDTO["score"];
      newsletter = inputDTO["newsletter"];
      rules = inputDTO["rules"];
      timestamp = inputDTO["timestamp"];
    }
  }

  @override
  Map toJson() {
    return {
      "uid": uid,
      "hash": hash,
      "birthday_date": birthday_date,
      "hometown_location": hometown_location,
      "title": title,
      "firstname": firstname,
      "lastname": lastname,
      "street": street,
      "additional": additional,
      "city": city,
      "county": county,
      "country": country,
      "email": email,
      "email_confirmed": email_confirmed,
      "score": score,
      "newsletter": newsletter,
      "rules": rules,
      "timestamp": timestamp
    };
  }

}
