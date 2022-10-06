import 'package:flutter/material.dart';

import '../consts/colors.dart';

class DialogTextInputField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  const DialogTextInputField(
      {Key? key,
        required this.textEditingController,
        required this.hintText,
        })
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

      ),
      keyboardType: TextInputType.multiline,
      minLines: 2,
      maxLines:8 ,

    );
  }
}
