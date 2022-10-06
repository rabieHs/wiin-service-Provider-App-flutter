import 'package:flutter/material.dart';

import '../consts/colors.dart';

class CustomAppBar extends StatelessWidget {
 final String title;
  const CustomAppBar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return appBar(context);
  }
  PreferredSizeWidget appBar(BuildContext context){
     return AppBar(
        title: Text(title,style: TextStyle(color: black,fontWeight: FontWeight.w500, fontSize: 23)),
       leading: GestureDetector(onTap: (){Navigator.pop(context);},child: Icon(Icons.arrow_back_ios,color: black,size: 30,)),
       backgroundColor: white,
       elevation: 0,
    );
  }
}
