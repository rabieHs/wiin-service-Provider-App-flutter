import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../consts/colors.dart';

class PopMenu extends StatelessWidget {
  const PopMenu({Key? key, required this.menuList}) : super(key: key);
  final List<PopupMenuEntry> menuList;
  @override
  Widget build(BuildContext context) {

    return PopupMenuButton(itemBuilder: ((context)=>menuList),
      icon: Icon(Icons.more_vert_rounded,color: green,size: 28,),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),



    );
  }
}
