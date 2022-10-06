import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:wiin/data/chat_messages_model.dart';
import 'package:wiin/data/chat_model.dart';
import 'package:wiin/providers/user_provider.dart';
import 'package:wiin/widgets/message_buuble.dart';

import '../consts/colors.dart';
import 'dart:math' as math;

class ChatPageScreen extends StatefulWidget {
  final List<ChatMessages> messages;
  final String name;
  final String image;
  const ChatPageScreen(
      {Key? key,
      required this.messages,
      required this.name,
      required this.image})
      : super(key: key);

  @override
  State<ChatPageScreen> createState() => _ChatPageScreenState();
}

class _ChatPageScreenState extends State<ChatPageScreen> {
  late double _deviceHeight;
  late double _deviceWidth;
  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: _deviceHeight * 0.15,
        elevation: 0,
        backgroundColor: searchGrey,
        title: _header(),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: _content()),
          _sendBar(),
        ],
      ),
    );
  }

  Widget _header() {
    final user = Provider.of<UserProvider>(
      context,
    ).user;
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(
              Icons.arrow_back_ios,
              size: 25,
              color: primary,
            ),
          ),
          CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage(widget.image),
          ),
          Container(
            width: _deviceWidth * 0.4,
            height: _deviceHeight * 0.070,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  user.name,
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500, color: black),
                ),
                Text(
                  "Online",
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w400, color: grey),
                )
              ],
            ),
          ),
          Icon(
            CupertinoIcons.phone_solid,
            color: primary,
            size: 35,
          ),
          Icon(
            CupertinoIcons.video_camera_solid,
            color: primary,
            size: 35,
          ),
          Icon(
            Icons.more_vert_rounded,
            color: primary,
            size: 35,
          ),
        ],
      ),
    );
  }

  Widget _content() {
    return Container(
        height: _deviceHeight * 0.745,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: _deviceHeight * 0.03),
                child: Center(
                    child: Text(
                  "Today",
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                )),
              ),
              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  padding:
                      EdgeInsets.symmetric(horizontal: _deviceWidth * 0.04),
                  shrinkWrap: true,
                  itemCount: widget.messages.length,
                  itemBuilder: (BuildContext context, int index) {
                    final bool isOwnMessage = chats[index].senderId == "123";
                    return isOwnMessage
                        ? MessageOwnTile(
                            message: widget.messages[index].content,
                            messageDate: widget.messages[index].sentTime)
                        : MessageTile(
                            message: widget.messages[index].content,
                            messageDate: widget.messages[index].sentTime);
                  })
            ],
          ),
        ));
  }

  Widget _sendBar() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: _deviceWidth * 0.04, vertical: _deviceHeight * 0.01),
      child: Container(
        width: _deviceWidth,
        height: _deviceHeight * 0.06,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(width: 1, color: grey),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                Icons.camera_alt,
                color: primary,
                size: 35,
              ),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                      hintText: "Type your message...",
                      border: InputBorder.none),
                ),
              ),
              Icon(
                Icons.attach_file_rounded,
                color: primary,
                size: 35,
              ),
              Transform.rotate(
                  angle: -math.pi / 7,
                  child: Icon(
                    Icons.send_outlined,
                    color: primary,
                    size: 35,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
