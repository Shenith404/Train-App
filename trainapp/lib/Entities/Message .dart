import 'dart:math';

import 'package:trainapp/Entities/AppUser.dart';

class Message {
  String _messageId = "null";
  AppUser? _user;
  String _timeSpan = "null";
  String _content = "null";

  Message(this._messageId, this._user, this._timeSpan, this._content);

  String get messageId => _messageId;
  set messageId(String value) => _messageId = value;

  AppUser? get user => _user;
  set user(AppUser? value) => _user = value;

  String get timeSpan => _timeSpan;
  set timeSpan(String value) => _timeSpan = value;

  String get content => _content;
  set content(String value) => _content = value;

  static List<Message> generateRandomMessages(int count) {
    List<Message> messages = [];

    for (int i = 1; i <= count; i++) {
      messages.add(Message(
        i.toString(),
        null,
        getRandomTimeSpan(),
        getRandomContent(),
      ));
    }

    return messages;
  }

  static String getRandomTimeSpan() {
    final random = Random();
    final hours = random.nextInt(24);
    final minutes = random.nextInt(60);
    return "$hours hours and $minutes minutes ago";
  }

  static String getRandomContent() {
    List<String> sampleContent = [
      "Hello!",
      "Hi there!",
      "Greetings!",
      "How are you?",
      "Flutter is awesome! sdkfg;dskf;sdkgfkdg kdgsajdfjsdfj asjdfl jasljfksdj flksdkajflsjlfkjsdlkfjsadj flskdjf;lkdsjflsj flksdjflksdjflksjdflj",
    ];
    final random = Random();
    return sampleContent[random.nextInt(sampleContent.length)];
  }
}
