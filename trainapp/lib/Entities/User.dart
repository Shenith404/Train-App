class User {
  String _userId = "null";
  String _email = "null";
  String _password = "null";
  String _role = "null";
  String? imageUrl;

  User(this._userId, this._email, this._password, this._role, this.imageUrl);

  String get userId => _userId;
  set userId(String value) => _userId = value;

  String get email => _email;
  set email(String value) => _email = value;

  String get password => _password;
  set password(String value) => _password = value;

  String get role => _role;
  set role(String value) => _role = value;
}