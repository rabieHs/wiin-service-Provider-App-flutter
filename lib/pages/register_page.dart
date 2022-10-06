import 'package:flutter/material.dart';
import 'package:wiin/pages/login_page.dart';
import 'package:wiin/pages/reset_password_page.dart';
import 'package:wiin/services/auth_services.dart';

import '../consts/colors.dart';
import '../widgets/check_container.dart';
import '../widgets/custom_text_input_field.dart';
import '../widgets/rounded_button.dart';
import 'HomePage.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  late double _deviceHeight;
  late double _deviceWidth;
  late String type;
  bool isPressed = false;
  final AuthServices authServices = AuthServices();

//functions

  void registerUser() {
    authServices.registerUser(
        context: context,
        email: _emailController.text,
        password: _passwordController.text,
        name: _userNameController.text,
        phone: _phoneNumberController.text,
        type: type);
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: _deviceWidth * 0.06, vertical: _deviceHeight * 0.03),
        child: Column(
          children: [
            _welcomeUI(),
            SizedBox(
              height: _deviceHeight * 0.05,
            ),
            _formField(),
            SizedBox(
              height: _deviceHeight * 0.02,
            ),
            _registerOption(),
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
              width: _deviceWidth * 0.36,
            ),
            Column(
              children: [
                Column(
                  children: const [
                    Text(
                      "Have an ",
                      style: TextStyle(
                          color: grey,
                          fontWeight: FontWeight.w400,
                          fontSize: 13),
                    ),
                    Text(
                      " Account ?",
                      style: TextStyle(
                          color: grey,
                          fontWeight: FontWeight.w400,
                          fontSize: 13),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                  child: Text(
                    "Sign in",
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
          "Sign up",
          style: TextStyle(
              color: black, fontWeight: FontWeight.w500, fontSize: 60),
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
        SizedBox(
          height: _deviceHeight * .025,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: _deviceWidth * 0.4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "username",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: _deviceHeight * 0.025,
                  ),
                  CustomTextInputField(
                      textEditingController: _userNameController,
                      isPass: false,
                      hintText: "username ",
                      textInputType: TextInputType.emailAddress),
                ],
              ),
            ),
            SizedBox(
              width: _deviceWidth * 0.4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Contact number",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: _deviceHeight * 0.025,
                  ),
                  CustomTextInputField(
                      textEditingController: _phoneNumberController,
                      isPass: false,
                      hintText: "Contact number",
                      textInputType: TextInputType.emailAddress),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: _deviceHeight * 0.02,
        ),
        const Text(
          "Enter your Password",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        ),
        SizedBox(
          height: _deviceHeight * 0.025,
        ),
        CustomTextInputField(
            textEditingController: _passwordController,
            isPass: true,
            hintText: "password",
            textInputType: TextInputType.emailAddress),
        SizedBox(
          height: _deviceHeight * 0.02,
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const ResetPasswordPage()));
            },
            child: const Text(
              "Forgot Password",
              style: TextStyle(
                  color: green, fontSize: 14, fontWeight: FontWeight.w400),
            ),
          ),
        )
      ],
    );
  }

  Widget _registerOption() {
    return Column(
      children: [
        Row(
          children: const [
            Text(
              "Register as ",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              "(Select one) ",
              style: TextStyle(
                  color: green, fontSize: 16, fontWeight: FontWeight.w400),
            ),
          ],
        ),
        SizedBox(
          height: _deviceHeight * 0.02,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Wrap(
                spacing: 25.0,
                runSpacing: 15.0,
                children: [
                  CheckContainer(
                    onTap: () {
                      print('success');
                      setState(() {
                        type = "Provider";
                      });
                    },
                    title: 'Service Provider',
                  ),
                  CheckContainer(
                    title: 'Service Searcher',
                    onTap: () {
                      print('success1');
                      setState(() {
                        type = 'Searcher';
                      });
                    },
                  ),
                ],
              ),
            )
          ],
        )
      ],
    );
  }

  /*Widget _choisebox(String text,bool isPressed,Function()? function) {
    return GestureDetector(
        child: Container(
      padding: EdgeInsets.only(top: 2),
      child: TextButton(
        onPressed: function,
        child: Container(
          decoration: BoxDecoration(
            color: isPressed? green:null,
            border: Border.all(color: isPressed? green:grey),
            borderRadius: BorderRadius.circular(5),
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(color: isPressed? white: grey, fontWeight: FontWeight.bold),
          ),
          height: _deviceHeight * 0.07,
          width: _deviceWidth*0.35,
        ),
      ),
    ));
  }*/
  Widget _choisebox(String text) {
    return ChoiceChip(
      label: Text("custome"),
      selected: isPressed,
      selectedColor: isPressed ? green : grey,
      onSelected: (_isSelected) {
        setState(() {
          isPressed = _isSelected;
        });
      },
    );
  }

  Widget _loginButton() {
    return RoundedButton(
      name: "Sign up",
      height: _deviceHeight * 0.07,
      width: _deviceWidth,
      onPressed: registerUser,
    );
  }
}
