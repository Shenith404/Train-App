
import "package:trainapp/Entities/User.dart";

class Message {
  String _messageId = "null";
  User? _user;
  String _timeSpan = "null";
  String _content = "null";

  Message(this._messageId, this._user, this._timeSpan, this._content);

  String get messageId => _messageId;
  set messageId(String value) => _messageId = value;

  User? get user => _user;
  set user(User? value) => _user = value;

  String get timeSpan => _timeSpan;
  set timeSpan(String value) => _timeSpan = value;

  String get content => _content;
  set content(String value) => _content = value;
}