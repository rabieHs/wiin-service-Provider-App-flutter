import 'package:flutter/material.dart';
import 'package:wiin/consts/colors.dart';

class InfoBox extends StatelessWidget {
  final String label;
  final String data;
  final double height;
  final double width;
  const InfoBox({Key? key, required this.label, required this.data, required this.height, required this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border:Border.all(width: 1,color: grey) ,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(label,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: grey),),
              Text(data,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: black.withOpacity(0.7)),),
            ],
          ),
        ),
      ),
    );
  }
}
