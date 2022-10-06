import 'package:flutter/material.dart';

import '../consts/colors.dart';
import '../widgets/custom_text_input_field.dart';
import '../widgets/rounded_button.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  late double _deviceHeight;
  late double _deviceWidth;
  final TextEditingController _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: _deviceWidth * 0.06, vertical: _deviceHeight * 0.04),
        child: Column(
          children: [
            _welcomeUI(),
            SizedBox(
              height: _deviceHeight * 0.09,
            ),
            _formField(),

            SizedBox(
              height: _deviceHeight * 0.05,
            ),
            _sendButton()
          ],
        ),
      ),
    );
  }
  Widget _welcomeUI(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
          height: _deviceHeight * 0.01,
        ),
        const Text(
          "Forgot Password",
          style: TextStyle(
          color: black, fontWeight: FontWeight.w500, fontSize: 40),
        ),
      ]
    );
  }
  Widget _formField(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Enter your username or email address",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        ),
        SizedBox(
          height: _deviceHeight * 0.025,
        ),
        CustomTextInputField(
            textEditingController: _emailController,
            isPass: false,
            hintText: "username or email address",
            textInputType: TextInputType.emailAddress),
      ],
    );
  }
  Widget _sendButton(){
    return RoundedButton(
        name: "Send",
        height: _deviceHeight * 0.07,
        width: _deviceWidth,
        onPressed: () {});
  }
}
