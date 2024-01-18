import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trainapp/Colours/Colors.dart';
import 'package:trainapp/Entities/Message%20.dart';
import 'package:trainapp/Services/ChatService.dart';
import 'package:trainapp/Services/auth.dart';
import 'package:trainapp/Widgets/MessageBubble.dart';

import '../Widgets/Loading.dart';

class ChatPage extends StatefulWidget {
  final routeName;
  final routeImage;
  final members;
  const ChatPage({super.key, this.routeName, this.routeImage, this.members});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final chatService = ChatService();
  final _auth =FirebaseAuth.instance;
  ScrollController _scrollController= ScrollController();
  @override
  Widget build(BuildContext context) {



    return _chatPage();
  }

  Scaffold _chatPage() {


    // create controller
    TextEditingController ?messageContentController = TextEditingController();
    // create chateservice instance


    //send message
    void sendeMessage() async{
      if(messageContentController.text.isNotEmpty){
        var now = DateTime.now();
        var formatterDate = DateFormat('dd/MM/yy');
        var formatterTime = DateFormat('kk:mm');
        String actualTime = formatterTime.format(now);

        /* setState(() {
           now = DateTime.now();
        });*/

        await chatService.sendMessage(widget.routeName, messageContentController.text,actualTime,now);
        messageContentController.clear();
      }

    }
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
              child:_buildMessageList()
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height/8,
            )
          ],
        ),
        Align(
          alignment: Alignment.center,
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
                      controller: messageContentController,
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
                    child:  IconButton(
                        onPressed: sendeMessage,
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
  Widget _buildMessageList(){
    return StreamBuilder(
      stream: chatService.getMessages(widget.routeName),
      builder: (context,snapshot){
        if(snapshot.hasError){
          return Text(snapshot.error.toString());
        }
        if(snapshot.connectionState==ConnectionState.waiting){
          return Loading();
        }
        //To get scroll to down
        WidgetsBinding.instance!.addPostFrameCallback((_) {
          _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
        });
        return ListView(
          controller: _scrollController,
          children: snapshot.data!.docs
              .map((doc) => _bildMessageItem(doc))
              .toList(),
        );
      },
    );
  }

  Widget _bildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    debugPrint(data.toString());
    bool isMe=false;

    //aligmnet of message
    var allignment = (data["senderId"] == _auth.currentUser!.uid)
        ? isMe=true
        : isMe=false;

   
    return Container(

        child: Column(
          children: [
            MessageBubble(sender: data['senderUserName'] ?? "App user",content: data['content'], time: data['timeSpan'], isMe: isMe),
          ],
        ));
  }
  }


