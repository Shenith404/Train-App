import 'package:trainapp/Entities/Message .dart';

class TrainRoute {
  String _routeId = "null";
  String _routeName = "null";
  List<Message> _chatList = [];
  List<String> _trainList = [];

  TrainRoute(this._routeId, this._routeName, this._chatList, this._trainList);

  String get routeId => _routeId;
  set routeId(String value) => _routeId = value;

  String get routeName => _routeName;
  set routeName(String value) => _routeName = value;

  List<Message> get chatList => _chatList;
  set chatList(List<Message> value) => _chatList = value;

  List<String> get trainList => _trainList;
  set trainList(List<String> value) => _trainList = value;

  static List<TrainRoute> routeList() {
    return [
      TrainRoute("ru01", "Kandy to Galle", [], []),
      TrainRoute("ru01", "Kandy to Matara", [], []),
      TrainRoute("ru01", "Kandy to Colombo", [], []),
      TrainRoute("ru01", "Kandy to Anuradapura", [], []),
      TrainRoute("ru01", "Kandy to Matale", [], []),
      TrainRoute("ru01", "Kandy to Kurunegala", [], []),
      TrainRoute("ru01", "Kandy to Jaffna", [], []),
      TrainRoute("ru01", "Kandy to Badulla", [], []),
      TrainRoute("ru01", "Kandy to Polgahawela", [], []),
      TrainRoute("ru01", "Kandy to Ella", [], []),
    ];
  }
}
