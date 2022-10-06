import 'package:flutter/material.dart';
import 'package:wiin/consts/colors.dart';
import 'package:wiin/pages/HomePage.dart';
import 'package:wiin/pages/register_page.dart';
import 'package:wiin/pages/reset_password_page.dart';
import 'package:wiin/services/auth_services.dart';
import 'package:wiin/widgets/custom_text_input_field.dart';
import 'package:wiin/widgets/rounded_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late double _deviceHeight;
  late double _deviceWidth;
  final AuthServices authServices = AuthServices();

  void loginUser() {
    authServices.loginUser(
        context: context,
        email: _emailController.text,
        password: _passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: _deviceWidth * 0.06, vertical: _deviceHeight * 0.05),
        child: Column(
          children: [
            _welcomeUI(),
            SizedBox(
              height: _deviceHeight * 0.09,
            ),
            _loginOptions(),
            SizedBox(
              height: _deviceHeight * 0.1,
            ),
            _formField(),
            SizedBox(
              height: _deviceHeight * 0.05,
            ),
            _loginButton()
          ],
        ),
      ),
    );
  }

  Widget _welcomeUI() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Row(
              children: [
                const Text(
                  "Welcome to",
                  style: TextStyle(
                      color: black, fontWeight: FontWeight.w400, fontSize: 16),
                ),
                SizedBox(
                  width: _deviceWidth * 0.01,
                ),
                const Text(
                  "WiiN",
                  style: TextStyle(
                      color: green, fontWeight: FontWeight.w500, fontSize: 16),
                )
              ],
            ),
            SizedBox(
              width: _deviceWidth * 0.34,
            ),
            Column(
              children: [
                Text(
                  "No Account ?",
                  style: TextStyle(
                      color: grey, fontWeight: FontWeight.w400, fontSize: 13),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => RegisterPage()));
                  },
                  child: Text(
                    "Sign up",
                    style: TextStyle(
                        color: green,
                        fontWeight: FontWeight.w400,
                        fontSize: 13),
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(
          height: _deviceHeight * 0.01,
        ),
        const Text(
          "Sign in",
          style: TextStyle(
              color: black, fontWeight: FontWeight.w500, fontSize: 60),
        ),
      ],
    );
  }

  Widget _loginOptions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          height: _deviceHeight * 0.07,
          width: _deviceWidth * 0.6,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(9), color: primarylight),
          child: Align(
            alignment: Alignment.centerRight,
            child: Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
                Image.asset(
                  "assets/images/google.png",
                  width: 20,
                ),
                const SizedBox(
                  width: 12,
                ),
                const Text(
                  "Sign in with Google",
                  style: TextStyle(
                      color: primary,
                      fontWeight: FontWeight.w400,
                      fontSize: 15),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          width: _deviceWidth * 0.035,
        ),
        Container(
          height: _deviceHeight * 0.07,
          width: _deviceWidth * 0.10,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(9), color: lightGrey),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 19, horizontal: 9),
            child: Image.asset(
              "assets/images/facebook.png",
            ),
          ),
        ),
        SizedBox(
          width: _deviceWidth * 0.02,
        ),
        Container(
          height: _deviceHeight * 0.07,
          width: _deviceWidth * 0.10,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(9), color: lightGrey),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 19, horizontal: 9),
            child: Image.asset(
              "assets/images/apple.png",
            ),
          ),
        ),
      ],
    );
  }

  Widget _formField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Enter your username or email address",
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        SizedBox(
          height: _deviceHeight * 0.025,
        ),
        CustomTextInputField(
            textEditingController: _emailController,
            isPass: false,
            hintText: "username or email address",
            textInputType: TextInputType.emailAddress),
        SizedBox(
          height: _deviceHeight * .025,
        ),
        const Text(
          "Enter your Password",
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        SizedBox(
          height: _deviceHeight * 0.025,
        ),
        CustomTextInputField(
            textEditingController: _passwordController,
            isPass: true,
            hintText: "password",
            textInputType: TextInputType.text),
        SizedBox(
          height: _deviceHeight * 0.02,
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ResetPasswordPage()));
              },
              child: Text(
                "Forgot Password",
                style: TextStyle(
                    color: green, fontSize: 14, fontWeight: FontWeight.w400),
              )),
        )
      ],
    );
  }

  Widget _loginButton() {
    return RoundedButton(
      name: "Sign in",
      height: _deviceHeight * 0.07,
      width: _deviceWidth,
      onPressed: loginUser,
    );
  }
}
