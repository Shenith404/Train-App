
import 'package:flutter/material.dart';

class Alert extends StatelessWidget {
  final String Message;
  final String Title;
  const Alert({super.key, required this.Message, required this.Title});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(Title),
      actions: [

      ],
      content:   Text(Message.toString(),
        maxLines: 2,
        style: TextStyle(
          color: Colors.red,
        ),),
      elevation: 21,

    );
  }
}
