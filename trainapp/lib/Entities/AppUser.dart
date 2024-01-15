class AppUser {
  final String _AppUserId;
  String _email ="null" ;

  String _role = "null";
  String? imageUrl;

  AppUser(
      this._AppUserId);

  String get AppUserId => _AppUserId;
  //set AppUserId(String value) => _AppUserId = value;

  String get email => _email;
  set email(String value)=>_email=value;


 /* String get password => _password;
  set password(String value) => _password = value;*/

  String get role => _role;
  set role(String value) => _role = value;
}
