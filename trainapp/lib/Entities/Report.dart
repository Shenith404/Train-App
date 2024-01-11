import 'package:trainapp/Entities/AppUser.dart';

class Report {
  String _reportId = "null";
  String _title = "null";
  String _content = "null";
  String _type = "null";
  AppUser? _user;
  bool _isRead = false;

  Report(this._reportId, this._title, this._content, this._type, this._user,
      this._isRead);

  String get reportId => _reportId;
  set reportId(String value) => _reportId = value;

  String get title => _title;
  set title(String value) => _title = value;

  String get content => _content;
  set content(String value) => _content = value;

  String get type => _type;
  set type(String value) => _type = value;

  AppUser? get user => _user;
  set user(AppUser? value) => _user = value;

  bool get isRead => _isRead;
  set isRead(bool value) => _isRead = value;
}
