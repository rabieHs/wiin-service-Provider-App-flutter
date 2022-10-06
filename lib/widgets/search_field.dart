import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../consts/colors.dart';

class SearchField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final TextInputType textInputType;
  final Function(String) onSubmitted;
  const SearchField({
    Key? key,
    required this.textEditingController,
    required this.hintText,
    required this.textInputType,
    required this.onSubmitted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
        borderRadius: BorderRadius.circular(9), borderSide: BorderSide.none);

    return TextFormField(
      controller: textEditingController,
      onFieldSubmitted: onSubmitted,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.search,
          size: 30,
          color: grey,
        ),
        fillColor: searchGrey,
        filled: true,
        hintText: hintText,
        hintStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
        border: inputBorder,
        contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      ),
      keyboardType: textInputType,
    );
  }
}
