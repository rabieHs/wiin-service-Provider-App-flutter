import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wiin/consts/colors.dart';
import 'package:wiin/data/Works_model.dart';
import 'package:wiin/home_screens/work_detail_screen.dart';

class WorkCard extends StatelessWidget {
  final WorksModel work;
  final String image;
  final String title;
  const WorkCard(
      {Key? key, required this.work, required this.image, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    late double _deviceHeight = MediaQuery.of(context).size.height;
    late double _deviceWidth = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => WorkDetailScreen(snap: work)));
      },
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: _deviceWidth * 0.3,
              height: _deviceWidth * 0.3,
              decoration: BoxDecoration(
                  color: primary,
                  borderRadius: BorderRadius.circular(9),
                  image: DecorationImage(
                    image: NetworkImage(image),
                    fit: BoxFit.cover,
                  )),
            ),
            Text(
              title,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
            ),
            Text(
              '',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
              maxLines: 3,
            ),
          ],
        ),
      ),
    );
  }
}
