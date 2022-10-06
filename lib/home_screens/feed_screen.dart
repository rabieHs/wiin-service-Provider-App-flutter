import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wiin/data/post_model.dart';
import 'package:wiin/home_screens/search_screen.dart';
import 'package:wiin/providers/user_provider.dart';
import 'package:wiin/services/posts_services.dart';
import 'package:wiin/widgets/custom_text_input_field.dart';
import 'package:wiin/widgets/search_field.dart';
import 'dart:math' as math;

import '../widgets/post_card.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  late double _deviceHeight;
  late double _deviceWidth;
  final TextEditingController _searchController = TextEditingController();
  bool isProvider = false;
  PostsServices postsServices = PostsServices();
  List<Post>? postsList;

  void navigateToSearchScreen(String query) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => SearchScreen(query: query)));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPosts();
  }

  void getPosts() async {
    postsList = await postsServices.getPosts(context: context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context).user;

    if (user.type == 'Provider') {
      setState(() {
        isProvider = true;
      });
    }

    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: _deviceWidth * 0.04, vertical: _deviceHeight * 0.02),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _searchBar(),
              SizedBox(
                height: _deviceHeight * 0.04,
              ),
              postsList == null
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : _postsList()
            ],
          ),
        ),
      ),
    );
  }

  Widget _searchBar() {
    return Row(
      children: [
        SizedBox(
          width: _deviceWidth * 0.03,
        ),
        Container(
            height: _deviceHeight * 0.08,
            width: _deviceWidth * 0.76,
            child: SearchField(
              onSubmitted: navigateToSearchScreen,
              textEditingController: _searchController,
              hintText: "Searching for...",
              textInputType: TextInputType.text,
            )),
        SizedBox(
          width: _deviceWidth * 0.02,
        ),
        Transform.rotate(
            angle: -math.pi / 2,
            child: const Icon(
              CupertinoIcons.slider_horizontal_3,
              size: 40,
            ))
      ],
    );
  }

  Widget _postsList() {
    return ListView.builder(
      itemCount: postsList?.length,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        final postData = postsList![index];
        return isProvider
            ? PostCardSearcher(
                contextt: context,
                userId: postData.userId,
                name: postData.name,
                time: postData.time,
                content: postData.description,
                image: postData.image,
                onTap: () {
                  Navigator.pop(context);
                })
            : PostCardProvider(
                contextt: context,
                userId: postData.userId,
                name: postData.name,
                time: postData.time,
                content: postData.description,
                image: postData.image,
                onTap: () {
                  Navigator.pop(context);
                });
      },
    );
  }
}
