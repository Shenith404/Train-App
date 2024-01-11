import 'package:trainapp/Entities/TrainRoute.dart';
import 'package:trainapp/Entities/AppUser.dart';

class Notification {
  String _notificationId = "null";
  String _title = "null";
  String _content = "null";
  TrainRoute? _route;
  AppUser? _user;

  Notification(this._notificationId, this._title, this._content, this._route,
      this._user);

  String get notificationId => _notificationId;
  set notificationId(String value) => _notificationId = value;

  String get title => _title;
  set title(String value) => _title = value;

  String get content => _content;
  set content(String value) => _content = value;

  TrainRoute? get route => _route;
  set route(TrainRoute? value) => _route = value;

  AppUser? get user => _user;
  set user(AppUser? value) => _user = value;
}
