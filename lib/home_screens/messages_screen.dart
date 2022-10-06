import 'package:flutter/material.dart';
import 'package:wiin/data/chat_model.dart';
import 'package:wiin/widgets/chat_card.dart';
import 'package:wiin/widgets/search_field.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({Key? key}) : super(key: key);

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  late double _deviceHeight;
  late double _deviceWidth;
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          top: _deviceHeight * 0.02,
          left: _deviceWidth * 0.05,
          right: _deviceWidth * 0.05,
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              SearchField(
                  onSubmitted: (_) {},
                  textEditingController: _searchController,
                  hintText: "Search",
                  textInputType: TextInputType.text),
              ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.only(top: _deviceHeight * 0.02),
                  itemCount: messages.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ChatCard(chat: messages[index]);
                  })
            ],
          ),
        ),
      ),
    );
  }
}
