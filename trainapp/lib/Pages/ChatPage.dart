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
    return _chatPage(list, actualTime);
  }

  Scaffold _chatPage(List<Message> list, String actualTime) {
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
        //Message List
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
        Hero(
          tag: "tag-${widget.routeName}",
          child: Align(
            alignment: Alignment.center,
          ),
        ),

        //Message Box
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    constraints: BoxConstraints(maxHeight: 100),
                    decoration: BoxDecoration(
                        color: bubbleColor2,
                        borderRadius: BorderRadius.circular(30)),
                    child: TextFormField(
                      maxLines: null,
                      style: TextStyle(color: secondaryColor),
                      cursorColor: secondaryColor,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Write your message",
                          hintStyle: TextStyle(color: secondaryColor),
                          labelStyle:
                              TextStyle(color: Colors.blue), // Text color
                          // Add a hint text
                          prefixIcon: IconButton(
                            onPressed: null,
                            icon: Icon(
                              Icons.emoji_emotions,
                              color: secondaryColor,
                            ),
                          ),
                          suffixIcon: IconButton(
                            onPressed: null,
                            icon: Icon(
                              Icons.gps_fixed_outlined,
                              color: secondaryColor,
                            ),
                          )),
                    ),
                  ),
                ),

                // send button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Container(
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: bubbleColor2),
                    child: const IconButton(
                        onPressed: null,
                        icon: Icon(
                          Icons.send,
                          color: secondaryColor,
                        )),
                  ),
                )
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
