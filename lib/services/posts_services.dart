import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wiin/consts/consts.dart';
import 'package:wiin/data/post_model.dart';
import 'package:wiin/providers/user_provider.dart';
import 'package:wiin/services/error_hundling.dart';
import 'package:http/http.dart' as http;

class PostsServices {
  void uploadPost({
    required BuildContext context,
    required String description,
  }) async {
    final user = Provider.of<UserProvider>(context, listen: false).user;

    try {
      Post post = Post(
        name: user.name,
        userId: user.id,
        time: DateTime.now().toString(),
        description: description,
        image: 'https://i.pravatar.cc/111',
      );

      http.Response postsRes =
          await http.post(Uri.parse('$uri/api/upload-posts'),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
                'x-auth-token': user.token,
              },
              body: post.toJson());
      httpErrorHundle(
          response: postsRes,
          context: context,
          onSuccess: () {
            showSnackBar(context, 'post was uploaded');
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<List<Post>> getPosts({
    required BuildContext context,
  }) async {
    var user = Provider.of<UserProvider>(context, listen: false).user;
    List<Post> posts = [];

    try {
      http.Response postsRes = await http.get(
        Uri.parse('$uri/api/get-posts'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': user.token,
        },
      );

      httpErrorHundle(
          response: postsRes,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(postsRes.body).length; i++) {
              posts.add(
                Post.fromJson(
                  jsonEncode(
                    jsonDecode(postsRes.body)[i],
                  ),
                ),
              );
            }
          });
    } catch (e) {
      showSnackBar(context, e.toString());
      Navigator.pop(context);
    }
    return posts;
  }

  Future<List<Post>> getSearchedPosts({
    required BuildContext context,
    required String query,
  }) async {
    var user = Provider.of<UserProvider>(context, listen: false).user;
    List<Post> posts = [];

    try {
      http.Response postsRes = await http.get(
        Uri.parse('$uri/api/posts/$query'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': user.token,
        },
      );

      httpErrorHundle(
          response: postsRes,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(postsRes.body).length; i++) {
              posts.add(
                Post.fromJson(
                  jsonEncode(
                    jsonDecode(postsRes.body)[i],
                  ),
                ),
              );
              print(posts);
            }
          });
    } catch (e) {
      showSnackBar(context, e.toString());
      Navigator.pop(context);
    }
    return posts;
  }
}
