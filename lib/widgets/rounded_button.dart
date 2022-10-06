import 'package:flutter/material.dart';
import 'package:wiin/consts/colors.dart';

class RoundedButton extends StatelessWidget {
  final String name;
  final double height;
  final double width;
  final Function onPressed;
  const RoundedButton(
      {Key? key,
        required this.name,
        required this.height,
        required this.width,
        required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child: TextButton(
        onPressed: ()=>onPressed(),
        child: Text(
          name,
          style: TextStyle(fontSize: 16, color: Colors.white, ),
        ),
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(height * 0.25),
          color: primary
      ),
    );
  }
}