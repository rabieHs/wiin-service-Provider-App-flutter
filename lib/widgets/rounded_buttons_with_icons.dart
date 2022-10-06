import 'package:flutter/material.dart';
import 'package:wiin/consts/colors.dart';

class RoundedButtonWithIcon extends StatelessWidget {
  final String name;
  final double height;
  final double width;
  final IconData icon;
  final Function onPressed;
  const RoundedButtonWithIcon(
      {Key? key,
        required this.name,
        required this.height,
        required this.width,
        required this.onPressed, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child: TextButton(
        onPressed: ()=>onPressed(),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(icon,color: white,size: 20,),
                Text(
                  name,
                  style: TextStyle(fontSize: 14, color: Colors.white, ),
                ),
              ],
            ),
          ),
        ),
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(height * 0.25),
          color: primarylight2
      ),
    );
  }


}


class RoundedButtonWithoutIcon extends StatelessWidget {
  final String name;
  final double height;
  final double width;
  final Function onPressed;
  const RoundedButtonWithoutIcon(
      {Key? key,
        required this.name,
        required this.height,
        required this.width,
        required this.onPressed,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child: TextButton(
        onPressed: ()=>onPressed(),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
            child: Text(
              name,
              style: TextStyle(fontSize: 14, color: Colors.white, ),
            ),
          ),
        ),
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(height * 0.25),
          color: primarylight2
      ),
    );
  }
}