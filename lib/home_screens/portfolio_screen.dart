import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wiin/data/Works_model.dart';

import 'package:wiin/home_screens/add_work_screen.dart';
import 'package:wiin/providers/user_provider.dart';
import 'package:wiin/services/works_services.dart';
import 'package:wiin/widgets/work_card.dart';

import '../consts/colors.dart';
import '../data/user_model.dart';
import '../services/profile_services.dart';

class PortfolioScreen extends StatefulWidget {
  final String userId;
  const PortfolioScreen({Key? key, required this.userId}) : super(key: key);

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  late double _deviceHeight;
  late double _deviceWidth;
  final WorksServices worksServices = WorksServices();
  List<WorksModel> worksList = [];
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
    fetchWorks();
    fetchUserData();
  }

  fetchUserData() async {
    userModel = await profileServices.collectData(
        context: context, userId: widget.userId);
    setState(() {});
  }

  void fetchWorks() async {
    print(widget.userId);
    worksList =
        await worksServices.fetchWorks(context: context, userId: widget.userId);
    setState(() {});
    print(worksList);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      floatingActionButton: userModel.id != user.id
          ? null
          : FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => AddWorkScreen()));
              },
            ),
      body: Padding(
        padding: EdgeInsets.only(
          top: _deviceHeight * 0.02,
          left: _deviceWidth * 0.05,
          right: _deviceWidth * 0.05,
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              _profileHeader(),
              Divider(
                height: 3,
                thickness: 2,
              ),
              SizedBox(
                height: _deviceHeight * 0.02,
              ),
              worksList == null
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : _worksView(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _profileHeader() {
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
      ],
    );
  }

  Widget _worksView() {
    return GridView.builder(
        shrinkWrap: true,
        itemCount: worksList.length,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 15,
            mainAxisSpacing: 1.5,
            childAspectRatio: 0.5),
        itemBuilder: (context, index) {
          final worksData = worksList[index];
          return WorkCard(
            work: worksData,
            title: worksData.title,
            image: worksData.images[0],
          );
        });
  }
}
