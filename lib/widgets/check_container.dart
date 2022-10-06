import 'package:flutter/material.dart';

import '../consts/colors.dart';

class CheckContainer extends StatefulWidget {
  const CheckContainer({Key? key, this.title = '', required this.onTap})
      : super(key: key);
  final String title;
  final VoidCallback onTap;

  @override
  State<StatefulWidget> createState() {
    return _CheckContainerState();
  }
}

class _CheckContainerState extends State<CheckContainer> {
  bool isChecked = false;
  late double _deviceWidth;
  late double _deviceHeight;
  @override
  Widget build(BuildContext context) {
    _deviceWidth = MediaQuery.of(context).size.width;
    _deviceHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        setState(() {
          isChecked = !isChecked;
          widget.onTap();
        });
      },
      child: Flexible(
        child: Container(
          height: _deviceHeight * 0.076,
          width: _deviceWidth * 0.4,
          child: Center(
            child: Text(
              widget.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isChecked ? white : grey,
              ),
            ),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(9),
            border: Border.all(color: isChecked ? green : grey),
            color: isChecked ? green : Colors.white,
          ),
        ),
      ),
    );
  }
}
