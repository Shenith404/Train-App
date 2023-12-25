import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trainapp/Colours/Colors.dart';
import 'package:trainapp/Entities/Message%20.dart';
import 'package:trainapp/Widgets/MessageBubble.dart';

class ChatPage extends StatefulWidget {
  final routeName;
  final routeImage;
  final members;
  const ChatPage({super.key, this.routeName, this.routeImage, this.members});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    var list = Message.generateRandomMessages(30);
    var now = DateTime.now();
    var formatterDate = DateFormat('dd/MM/yy');
    var formatterTime = DateFormat('kk:mm');
    String actualDate = formatterDate.format(now);
    String actualTime = formatterTime.format(now);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bubbleColor2,
        title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            widget.routeName,
            style: TextStyle(fontSize: 18, color: secondaryColor),
          ),
          Text(
            widget.members.toString() + " members",
            style: TextStyle(fontSize: 12, color: secondaryColor),
          )
        ]),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: IconButton(
                onPressed: null,
                icon: Icon(
                  Icons.train,
                  color: secondaryColor,
                )),
          )
        ],
      ),
      body: Stack(children: [
        Column(
          children: [
            Expanded(
              child: ListView(
                children: <Widget>[
                  for (var m in list)
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Column(children: [
                        MessageBubble(
                          content: m.content,
                          time: actualTime,
                          isMe: false,
                        ),
                      ]),
                    )
                ],
              ),
            ),
          ],
        ),
        // Row(
        //   children: [
        //     Container(
        //       decoration: BoxDecoration(
        //           color: bubbleColor2, borderRadius: BorderRadius.circular(30)),
        //       child: TextFormField(
        //         obscureText: false,
        //         decoration: const InputDecoration(
        //           hintText: "Write your message", // Add a hint text
        //           prefixIcon: Icon(
        //             Icons.emoji_emotions,
        //             color: secondaryColor,
        //           ),
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
      ]),
    );
  }
}
