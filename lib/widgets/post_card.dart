import 'package:flutter/material.dart';
import 'package:wiin/consts/colors.dart';
import 'package:wiin/home_screens/profile_screen.dart';
import 'package:wiin/pages/HomePage.dart';
import 'package:wiin/services/profile_services.dart';
import 'package:wiin/widgets/custom_text_input_field.dart';
import 'package:wiin/widgets/rounded_button.dart';

import 'message_dialog_field.dart';

class PostCardSearcher extends StatelessWidget {
  final String name;
  final String time;
  final String content;
  final String image;
  final String userId;
  final Function onTap;
  final BuildContext contextt;
  const PostCardSearcher({
    Key? key,
    required this.name,
    required this.time,
    required this.content,
    required this.image,
    required this.onTap,
    required this.userId,
    required this.contextt,
  }) : super(key: key);
  void navigateToProfileScreen() {
    Navigator.of(contextt).push(
        MaterialPageRoute(builder: (context) => ProfileScreen(userId: userId)));
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _messageController = TextEditingController();

    Future _showDialogSearcher() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Center(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Contact the Searcher"),
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.close_sharp)),
                ],
              )),
              content: DialogTextInputField(
                textEditingController: _messageController,
                hintText: "whrite your message here",
              ),
              actions: [
                Center(
                    child: RoundedButton(
                        name: "Send",
                        height: 35,
                        width: 250,
                        onPressed: () => onTap())),
                SizedBox(
                  height: 40,
                )
              ],
            ));

    late double _deviceHeight;
    late double _deviceWidth;
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Container(
          height: _deviceHeight * 0.27,
          width: _deviceWidth * 0.87,
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: grey.withOpacity(0.12),
              spreadRadius: 2,
              blurRadius: 15,
              offset: Offset(0, 1),
            ),
          ], color: white, borderRadius: BorderRadius.circular(15)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: _deviceHeight * 0.09,
                width: _deviceWidth,
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                    color: grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 15,
                    offset: Offset(0, 1),
                  ),
                ], color: white, borderRadius: BorderRadius.circular(15)),
                child: InkWell(
                  onTap: navigateToProfileScreen,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: _deviceWidth * 0.05,
                      ),
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage(image),
                      ),
                      SizedBox(
                        width: _deviceWidth * 0.02,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            name,
                            style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: darkGrey),
                          ),
                          Text(
                            time,
                            style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 11,
                                color: grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Text(
                    content,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: _showDialogSearcher,
                child: Container(
                  height: _deviceHeight * 0.045,
                  width: _deviceWidth,
                  decoration: const BoxDecoration(
                      color: primary,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15))),
                  child: const Center(
                    child: Text(
                      "Contact Searcher",
                      style: TextStyle(
                          color: white,
                          fontSize: 15,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: _deviceHeight * 0.02,
        )
      ],
    );
  }
}

class PostCardProvider extends StatelessWidget {
  final String name;
  final String userId;
  final String time;
  final BuildContext contextt;
  final String content;
  final String image;
  final Function()? onTap;
  const PostCardProvider(
      {Key? key,
      required this.name,
      required this.time,
      required this.content,
      required this.image,
      required this.onTap,
      required this.userId,
      required this.contextt})
      : super(key: key);
  void navigateToProfileScreen() {
    Navigator.of(contextt).push(
        MaterialPageRoute(builder: (context) => ProfileScreen(userId: userId)));
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _messageController = TextEditingController();

    Future _showDialogProvider() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Center(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Contact the Provider"),
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.close_sharp)),
                ],
              )),
              content: DialogTextInputField(
                textEditingController: _messageController,
                hintText: "whrite your message here",
              ),
              actions: [
                Center(
                    child: RoundedButton(
                        name: "Send",
                        height: 35,
                        width: 250,
                        onPressed: () => onTap!())),
                SizedBox(
                  height: 40,
                )
              ],
            ));

    late double _deviceHeight;
    late double _deviceWidth;
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Container(
          height: _deviceHeight * 0.27,
          width: _deviceWidth * 0.87,
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: grey.withOpacity(0.12),
              spreadRadius: 2,
              blurRadius: 15,
              offset: Offset(0, 1),
            ),
          ], color: white, borderRadius: BorderRadius.circular(15)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: _deviceHeight * 0.09,
                width: _deviceWidth,
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                    color: grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 15,
                    offset: Offset(0, 1),
                  ),
                ], color: white, borderRadius: BorderRadius.circular(15)),
                child: InkWell(
                  onTap: navigateToProfileScreen,
                  child: Row(
                    children: [
                      SizedBox(
                        width: _deviceWidth * 0.05,
                      ),
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage(image),
                      ),
                      SizedBox(
                        width: _deviceWidth * 0.02,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            name,
                            style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: darkGrey),
                          ),
                          Text(
                            time,
                            style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 11,
                                color: grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Text(
                    content,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Container(
                  height: _deviceHeight * 0.040,
                  width: _deviceWidth,
                  decoration: const BoxDecoration(
                      color: primary,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15))),
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: _deviceHeight * 0.002),
                        width: _deviceWidth * 0.42,
                        decoration: const BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                              //bottomRight: Radius.circular(15),
                            )),
                        child: const Center(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "See Provider’s Previous Works",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: primary,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: _showDialogProvider,
                        child: Container(
                          margin: EdgeInsets.only(top: _deviceHeight * 0.003),
                          height: _deviceHeight * 0.042,
                          width: _deviceWidth * 0.42,
                          decoration: const BoxDecoration(
                              color: primary,
                              borderRadius: BorderRadius.only(
                                // bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15),
                              )),
                          child: const Center(
                            child: Text(
                              "Contact Provider",
                              style: TextStyle(
                                  color: white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        ),
        SizedBox(
          height: _deviceHeight * 0.02,
        )
      ],
    );
  }
}
