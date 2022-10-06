import 'package:flutter/material.dart';
import 'package:wiin/services/posts_services.dart';
import 'package:wiin/widgets/custom_app_bar.dart';
import 'package:wiin/widgets/rounded_button.dart';

import '../consts/colors.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  late double _deviceHeight;
  late double _deviceWidth;
  final PostsServices postsServices = PostsServices();
  final TextEditingController _postController = TextEditingController();

  void uploadPost() {
    postsServices.uploadPost(
      context: context,
      description: _postController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(
        title: "New Post",
      ).appBar(context),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: _deviceWidth * 0.04, vertical: _deviceHeight * 0.02),
        child: Column(
          children: [
            _userRow(),
            SizedBox(
              height: _deviceHeight * 0.02,
            ),
            _postField(),
            SizedBox(
              height: _deviceHeight * 0.05,
            ),
            _sendButton(),
          ],
        ),
      ),
    );
  }

  Widget _userRow() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 27,
              backgroundImage: NetworkImage("https://i.pravatar.cc/300"),
            ),
            SizedBox(
              width: _deviceWidth * 0.05,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Rabie Houssaini",
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 18, color: black),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _postField() {
    return Container(
      height: _deviceHeight * 0.27,
      width: _deviceWidth * 0.87,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: grey.withOpacity(0.3),
          spreadRadius: 2,
          blurRadius: 15,
          offset: Offset(0, 1),
        ),
      ], color: white, borderRadius: BorderRadius.circular(15)),
      child: TextField(
        controller: _postController,
        decoration: const InputDecoration(
          hintText: "What do you want to talk about?",
          hintStyle: TextStyle(
              fontSize: 15, fontWeight: FontWeight.w400, color: black),
          border: OutlineInputBorder(borderSide: BorderSide.none),
          contentPadding: EdgeInsets.symmetric(vertical: 22, horizontal: 30),
        ),
        keyboardType: TextInputType.multiline,
        maxLines: 10,
        minLines: 1,
      ),
    );
  }

  Widget _sendButton() {
    return RoundedButton(
      name: "Post Now",
      height: _deviceHeight * 0.050,
      width: _deviceWidth * 0.88,
      onPressed: uploadPost,
    );
  }
}
