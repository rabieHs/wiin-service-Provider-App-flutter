import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wiin/consts/consts.dart';
import 'package:wiin/data/user_model.dart';
import 'package:wiin/home_screens/add_post_screen.dart';
import 'package:wiin/pages/HomePage.dart';
import 'package:wiin/pages/login_page.dart';
import 'package:wiin/pages/register_page.dart';
import 'package:wiin/providers/user_provider.dart';
import 'package:wiin/services/error_hundling.dart';

class ProfileServices {
  Future<UserModel> collectData(
      {required BuildContext context, required String userId}) async {
    UserModel userDetails = UserModel(
      name: '',
      email: '',
      password: '',
      type: '',
      phone: '',
      id: '',
      token: '',
    );
    try {
      final user = Provider.of<UserProvider>(context, listen: false).user;
      http.Response res =
          await http.get(Uri.parse('$uri/user'), headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': user.token,
        'userId': userId
      });

      httpErrorHundle(
        response: res,
        context: context,
        onSuccess: () {
          print(res.body);
          userDetails = UserModel.fromJson(jsonEncode(jsonDecode(res.body)));
          print(userDetails);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
      print(e.toString());
    }
    return userDetails;
  }
}
