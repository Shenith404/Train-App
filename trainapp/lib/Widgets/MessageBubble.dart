import "dart:math";

import "package:animate_do/animate_do.dart";
import "package:flutter/material.dart";
import "package:trainapp/Colours/Colors.dart";

class MessageBubble extends StatelessWidget {
  final String content;
  final String time;
  final bool isMe;
  final String sender;

  const MessageBubble({
    Key? key,
    required this.content,
    required this.time,
    required this.isMe, required this.sender,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var random = Random().nextInt(30).toDouble();
    return FadeInLeft(

      from: isMe? random :-random,
      duration: Duration(milliseconds: 300),
      child: Align(
        alignment: isMe ? Alignment.topRight : Alignment.topLeft,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          constraints:
              BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
          decoration: BoxDecoration(
            color: isMe ? bubbleColor1 : bubbleColor2,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: isMe? CrossAxisAlignment.end :CrossAxisAlignment.start,
            children: [
              !isMe ? Text(
                sender.toString(),
                style: TextStyle(color: shadowColor),
              ):SizedBox(),
              Text(
                content,
                style: TextStyle(color: !isMe ? secondaryColor : primaryColor),
              ),
              SizedBox(height: 1),
              Text(
                time,
                style: TextStyle(
                  color: !isMe ? secondaryColor : primaryColor,
                  fontSize: 8,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
