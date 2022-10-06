import 'package:flutter/material.dart';

import '../consts/colors.dart';

class CustomTextInputField extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool isPass;
  final String hintText;
  final TextInputType textInputType;
  const CustomTextInputField(
      {Key? key,
      required this.textEditingController,
      required this.isPass,
      required this.hintText,
      required this.textInputType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
        borderRadius: BorderRadius.circular(9),
        borderSide: BorderSide(width: 2, color: primary,));
    final enabledinputBorder =
        OutlineInputBorder(borderRadius: BorderRadius.circular(9),borderSide: BorderSide(width: 2, color: grey));
    final focusedinputBorder =
        OutlineInputBorder(borderRadius: BorderRadius.circular(9),borderSide: BorderSide(width: 2, color: primary));
    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
        border: inputBorder,

        focusedBorder: focusedinputBorder,
        enabledBorder: enabledinputBorder,
        contentPadding: EdgeInsets.symmetric(vertical: 22,horizontal: 20),
      ),
      keyboardType: textInputType,
      obscureText: isPass,
    );
  }
}
