import 'package:trainapp/Entities/Message .dart';
import 'package:trainapp/Entities/AppUser.dart';

class Location extends Message {
  Location(String locationName, AppUser user, String timeSpan, String content)
      : super("null", user, timeSpan, content);
}
