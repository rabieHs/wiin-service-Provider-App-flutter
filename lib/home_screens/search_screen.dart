import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wiin/data/post_model.dart';
import 'package:wiin/providers/user_provider.dart';
import 'package:wiin/services/posts_services.dart';
import 'package:wiin/widgets/post_card.dart';
import 'dart:math' as math;
import '../widgets/search_field.dart';

class SearchScreen extends StatefulWidget {
  final String query;
  const SearchScreen({Key? key, required this.query}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

late double _deviceHeight;
late double _deviceWidth;

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  PostsServices postsServices = PostsServices();
  List<Post>? postList;

  void navigateToSearchScreen(String query) {
    print(query);
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => SearchScreen(query: query)));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchSearchedProduct();
  }

  void fetchSearchedProduct() async {
    postList = await postsServices.getSearchedPosts(
        context: context, query: widget.query);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: _deviceWidth * 0.04,
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _searchBar(),
              SizedBox(
                height: _deviceHeight * 0.04,
              ),
              postList == null
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

  Widget _postsList() {
    final user = Provider.of<UserProvider>(context, listen: false).user;

    return ListView.builder(
        shrinkWrap: true,
        itemCount: postList!.length,
        itemBuilder: (context, index) {
          final postData = postList![index];
          return user.type == 'Provider'
              ? PostCardSearcher(
                  contextt: context,
                  userId: postData.userId,
                  name: postData.name,
                  time: postData.time,
                  content: postData.description,
                  image: postData.image,
                  onTap: () {})
              : PostCardProvider(
                  contextt: context,
                  userId: postData.userId,
                  name: postData.name,
                  time: postData.time,
                  content: postData.description,
                  image: postData.image,
                  onTap: () {});
        });
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
}
