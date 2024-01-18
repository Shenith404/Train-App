class AppUser {
  final String _AppUserId;
  String _email ="null" ;
  String _userName="";
  String _role = "null";
  String? imageUrl;

  AppUser(
      this._AppUserId,this._email,this._userName,this._role);

  String get AppUserId => _AppUserId;
  //set AppUserId(String value) => _AppUserId = value;

  String get email => _email;
  set email(String value)=>_email=value;

  String get userName => _userName;
  set userName(String value)=>_userName=value;


 /* String get password => _password;
  set password(String value) => _password = value;*/

  String get role => _role;
  set role(String value) => _role = value;
}
