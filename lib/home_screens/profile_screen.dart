import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wiin/data/user_model.dart';
import 'package:wiin/home_screens/portfolio_screen.dart';
import 'package:wiin/pages/HomePage.dart';
import 'package:wiin/providers/user_provider.dart';
import 'package:wiin/services/profile_services.dart';
import 'package:wiin/widgets/info_box.dart';
import 'package:wiin/widgets/pop_menu.dart';
import 'package:wiin/widgets/rounded_buttons_with_icons.dart';

import '../consts/colors.dart';

class ProfileScreen extends StatefulWidget {
  final String userId;

  const ProfileScreen({Key? key, required this.userId}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late double _deviceHeight;
  late double _deviceWidth;
  bool isProvider = false;
  ProfileServices profileServices = ProfileServices();
  UserModel userModel = UserModel(
      name: '',
      email: '',
      password: '',
      type: '',
      phone: '',
      id: '',
      token: '');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchUserData();
  }

  fetchUserData() async {
    userModel = await profileServices.collectData(
        context: context, userId: widget.userId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    bool isMe = false;
    if (userModel.id == user.id) {
      setState(() {
        isMe = true;
      });
    }

    if (userModel.type == 'Provider') {
      setState(() {
        isProvider = true;
      });
    }

    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: _deviceWidth * 0.05, vertical: _deviceHeight * 0.03),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              isMe ? _profileHeaderMe() : _profileHeaderUser(),
              SizedBox(
                height: _deviceHeight * 0.02,
              ),
              _profileInfo(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _profileHeaderUser() {
    return Column(
      children: [
        Row(
          children: [
            Container(
              height: _deviceWidth * 0.23,
              width: _deviceWidth * 0.23,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9),
                  color: primary,
                  image: const DecorationImage(
                      image: NetworkImage("https://i.pravatar.cc/300"),
                      fit: BoxFit.contain)),
            ),
            SizedBox(
              width: _deviceWidth * 0.03,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        userModel.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 19,
                            color: black),
                      ),
                      PopMenu(
                        menuList: [_reportItem()],
                      ),
                    ],
                  ),
                  const Text(
                    "Painter",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 17,
                        color: primarylight2),
                  ),
                  SizedBox(
                    height: _deviceHeight * 0.007,
                  ),
                  const Text(
                    "Gabes,Tunisia",
                    style: TextStyle(
                        fontWeight: FontWeight.w400, fontSize: 15, color: grey),
                  ),
                  SizedBox(
                    height: _deviceHeight * 0.025,
                  ),
                ],
              ),
            )
          ],
        ),
        SizedBox(
          height: _deviceHeight * 0.02,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RoundedButtonWithIcon(
                name: "Send Message",
                height: _deviceHeight * 0.05,
                width: _deviceWidth * 0.43,
                onPressed: () {},
                icon: Icons.message_outlined),
            RoundedButtonWithIcon(
                name: "See Portfolio",
                height: _deviceHeight * 0.05,
                width: _deviceWidth * 0.43,
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          PortfolioScreen(userId: widget.userId)));
                },
                icon: Icons.work_outline_outlined),
          ],
        ),
      ],
    );
  }

  Widget _profileHeaderMe() {
    return Column(
      children: [
        Row(
          children: [
            Container(
              height: _deviceWidth * 0.23,
              width: _deviceWidth * 0.23,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9),
                  color: primary,
                  image: const DecorationImage(
                      image: NetworkImage("https://i.pravatar.cc/300"))),
            ),
            SizedBox(
              width: _deviceWidth * 0.03,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userModel.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 19,
                            color: black),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: const Icon(
                          Icons.more_vert_rounded,
                          color: green,
                          size: 28,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: _deviceHeight * 0.007,
                  ),
                  const Text(
                    "Painter",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 17,
                        color: primarylight2),
                  ),
                  SizedBox(
                    height: _deviceHeight * 0.007,
                  ),
                  const Text(
                    "Gabes,Tunisia",
                    style: TextStyle(
                        fontWeight: FontWeight.w400, fontSize: 15, color: grey),
                  ),
                  SizedBox(
                    height: _deviceHeight * 0.025,
                  ),
                ],
              ),
            )
          ],
        ),
        SizedBox(
          height: _deviceHeight * 0.020,
        ),
        userModel.type != "Provider"
            ? Container()
            : Align(
                alignment: Alignment.centerRight,
                child: RoundedButtonWithIcon(
                    name: "See Portfolio",
                    height: _deviceHeight * 0.05,
                    width: _deviceWidth * 0.43,
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => HomePage(
                                selectedIndex: 4,
                              )));
                    },
                    icon: Icons.work_outline_outlined),
              ),
      ],
    );
  }

  Widget _profileInfo() {
    return Column(
      children: [
        InfoBox(
            label: "Name",
            data: userModel.name,
            height: _deviceHeight * 0.08,
            width: _deviceWidth),
        InfoBox(
            label: "Email",
            data: userModel.email,
            height: _deviceHeight * 0.08,
            width: _deviceWidth),
        InfoBox(
            label: "Location",
            data: "Gabes, Tunisia",
            height: _deviceHeight * 0.08,
            width: _deviceWidth),
        InfoBox(
            label: "Contact Number",
            data: userModel.phone,
            height: _deviceHeight * 0.08,
            width: _deviceWidth),
        InfoBox(
            label: "Date Of Birth",
            data: "12-03-2000",
            height: _deviceHeight * 0.08,
            width: _deviceWidth),
        InfoBox(
            label: "Gender",
            data: "Male",
            height: _deviceHeight * 0.08,
            width: _deviceWidth),
      ],
    );
  }

  PopupMenuEntry _reportItem() {
    return PopupMenuItem(
        onTap: () {
          print("tapped");
        },
        child: Row(
          children: [
            const Icon(
              Icons.report_gmailerrorred_outlined,
              color: green,
            ),
            SizedBox(
              width: _deviceWidth * 0.01,
            ),
            const Text(
              "Report User",
              style: TextStyle(color: green),
            ),
          ],
        ));
  }
}
