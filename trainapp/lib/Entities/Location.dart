import 'package:trainapp/Entities/Message .dart';
import "package:trainapp/Entities/User.dart";

class Location extends Message {
  Location(String locationName, User user, String timeSpan, String content)
      : super("null", user, timeSpan, content);
}
