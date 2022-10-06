import 'package:flutter/material.dart';
import 'package:wiin/consts/colors.dart';
import 'package:wiin/data/chat_messages_model.dart';
import 'package:wiin/data/chat_model.dart';
import 'package:wiin/home_screens/chat_page_screen.dart';

class ChatCard extends StatelessWidget {
  final ChatModel chat;
  const ChatCard({Key? key, required this.chat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool wasRead = chat.wasRead;
    return ListTile(
      contentPadding: EdgeInsets.only(right: 10,left: 0),
      leading: CircleAvatar(radius: 35,backgroundImage:NetworkImage(chat.image.toString()),),
      title: Text(chat.name,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
      subtitle: Text(chat.messages.first.content,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: grey),),
      trailing: !wasRead? Container(
        height: 10,
        width: 10,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: primary
        ),
      ): null,

      onTap:(){
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ChatPageScreen(messages: chat.messages, name: chat.name, image: chat.image.toString())));
      },


    );
  }
}
