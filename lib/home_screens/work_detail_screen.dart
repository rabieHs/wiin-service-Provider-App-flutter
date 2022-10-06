import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:wiin/consts/colors.dart';
import 'package:wiin/data/Works_model.dart';
import 'package:wiin/widgets/custom_app_bar.dart';
import 'package:wiin/widgets/custom_text_input_field.dart';
import 'package:wiin/widgets/rounded_buttons_with_icons.dart';

class WorkDetailScreen extends StatefulWidget {
  final WorksModel snap;
  const WorkDetailScreen({Key? key, required this.snap}) : super(key: key);

  @override
  State<WorkDetailScreen> createState() => _WorkDetailScreenState();
}

class _WorkDetailScreenState extends State<WorkDetailScreen> {
  late double _deviceHeight;
  late double _deviceWidth;
  late String _headerpic;
  late int index;
  final TextEditingController _feedbackController = TextEditingController();

  Future<int> _changePic(int _index) async {
    setState(() {
      index = _index;
    });

    print(index);
    return index;
  }

  @override
  void initState() {
    index = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    _headerpic = widget.snap.images[0];

    return Scaffold(
      appBar: CustomAppBar(title: "My Works").appBar(context),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: _deviceWidth * 0.01, vertical: _deviceHeight * 0.03),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _headerImage(),
              SizedBox(
                height: _deviceHeight * 0.01,
              ),
              _picturesList(),
              _contentDetail(),
              SizedBox(
                height: _deviceHeight * 0.01,
              ),
              _reviews(),
              SizedBox(
                height: _deviceHeight * 0.01,
              ),
              _feedbackField()
            ],
          ),
        ),
      ),
    );
  }

  Widget _headerImage() {
    final _index = index;
    return Container(
      height: _deviceWidth * 0.8,
      width: _deviceWidth,
      decoration: BoxDecoration(
          color: primary,
          borderRadius: BorderRadius.circular(9),
          image: DecorationImage(
              image: NetworkImage(widget.snap.images[_index]),
              fit: BoxFit.cover)),
    );
  }

  Widget _picturesList() {
    return Container(
      width: _deviceWidth,
      height: _deviceWidth * 0.25,
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: widget.snap.images.length,
          itemBuilder: (BuildContext context, int _index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () async {
                  _changePic(_index);
                  print("image${index}");
                },
                child: Container(
                  width: _deviceWidth * 0.25,
                  decoration: BoxDecoration(
                      color: primary,
                      borderRadius: BorderRadius.circular(5),
                      image: DecorationImage(
                          image: NetworkImage(widget.snap.images[_index]),
                          fit: BoxFit.cover)),
                ),
              ),
            );
          }),
    );
  }

  Widget _contentDetail() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: _deviceWidth * 0.05, vertical: _deviceHeight * 0.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.snap.title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: _deviceHeight * 0.01,
          ),
          Text(
            widget.snap.content,
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }

  Widget _reviews() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: _deviceWidth * 0.05, vertical: _deviceHeight * 0.02),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Reviews",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: _deviceHeight * 0.01,
          ),
          Container(
            width: _deviceWidth,
            height: _deviceHeight * 0.05,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                RatingBar.builder(
                  maxRating: 1,
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.orangeAccent,
                  ),
                  onRatingUpdate: (rating) {},
                  initialRating: 1,
                  updateOnDrag: true,
                ),
                SizedBox(
                  width: _deviceWidth * 0.05,
                ),
                Text(
                  "(10 Ratings)",
                  style: TextStyle(color: grey, fontSize: 15),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _feedbackField() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: _deviceWidth * 0.05),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Send Feedbacks",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Container(
            height: _deviceWidth * 0.25,
            width: _deviceWidth,
            child: Row(
              //mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                    width: _deviceWidth * 0.65,
                    child: CustomTextInputField(
                        textEditingController: _feedbackController,
                        isPass: false,
                        hintText: "Write your feedback here...",
                        textInputType: TextInputType.text)),
                RoundedButtonWithoutIcon(
                    name: "Send",
                    height: _deviceHeight * 0.07,
                    width: _deviceWidth * 0.19,
                    onPressed: () {})
              ],
            ),
          )
        ],
      ),
    );
  }
}
