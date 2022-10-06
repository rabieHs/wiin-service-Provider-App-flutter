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

class AuthServices {
  void registerUser(
      {required BuildContext context,
      required String email,
      required String password,
      required String name,
      required String phone,
      required String type}) async {
    try {
      UserModel user = UserModel(
        id: '',
        token: '',
        name: name,
        email: email,
        password: password,
        type: type,
        phone: phone,
      );
      http.Response res = await http.post(
          Uri.parse(
            '$uri/api/register',
          ),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: user.toJson());
      httpErrorHundle(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(context, 'register Success');
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => LoginPage()));
          });
    } catch (e) {}
  }

  void loginUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(
          Uri.parse(
            '$uri/api/login',
          ),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode({'email': email, 'password': password}));
      print(res.body);
      httpErrorHundle(
          response: res,
          context: context,
          onSuccess: () async {
            showSnackBar(context, 'login Success');
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => HomePage(
                      selectedIndex: 0,
                    )));
            final SharedPreferences prefs =
                await SharedPreferences.getInstance();
            Provider.of<UserProvider>(context, listen: false).setUser(res.body);
            await prefs.setString(
                'x-auth-token', jsonDecode(res.body)['token']);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void getUserData({
    required BuildContext context,
  }) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? token = await preferences.getString('x-auth-token');
      print(token);
      if (token == null) {
        preferences.setString('x-auth-token', '');
      }
      http.Response res = await http.post(
        Uri.parse('$uri/tokenIsValid'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token!
        },
      );
      var response = jsonDecode(res.body);
      if (response == true) {
        http.Response userRes = await http.get(Uri.parse('$uri/'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'x-auth-token': token
            });
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userRes.body);
        print(userRes.body);
      }
    } catch (e) {
      showSnackBar(context, e.toString());
      print(e);
    }
  }
}
