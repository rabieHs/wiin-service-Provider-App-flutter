import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wiin/consts/colors.dart';
import 'package:wiin/consts/screens_list.dart';
import 'package:wiin/home_screens/add_post_screen.dart';
import 'package:wiin/providers/user_provider.dart';

import '../home_screens/feed_screen.dart';
import '../home_screens/messages_screen.dart';
import '../home_screens/portfolio_screen.dart';
import '../home_screens/profile_screen.dart';

class HomePage extends StatefulWidget {
  int selectedIndex;
  HomePage({
    Key? key,
    required this.selectedIndex,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late double _deviceHeight;
  late double _deviceWidth;
  final ValueNotifier<String> title = ValueNotifier('Home');
  final bool isMe = true;

  static const List<Widget> _widgetOption = [
    Text('Index0:Home'),
    Text('Index1:Profile'),
    Text('Index2:Settings'),
    Text('Index3:Settings'),
  ];
  final pageTitles = [
    'Home',
    'Home',
    'Messages',
    'Profile',
    'Portfolio',
  ];
  void _onItemTapped(int Index) {
    _onNavigationItemSelected(Index);
    setState(() {
      widget.selectedIndex = Index;
      if (widget.selectedIndex == 1) {
        setState(() {
          widget.selectedIndex = 0;
        });
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => AddPostScreen()));
      }
    });
  }

  void _onNavigationItemSelected(index) {
    title.value = pageTitles[index];
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    List<Widget> HomeScreenItems = [
      const FeedScreen(),
      const AddPostScreen(),
      const MessagesScreen(),
      ProfileScreen(
        userId: user.id,
      ),
      PortfolioScreen(
        userId: user.id,
      ),
    ];
    var userProvider = Provider.of<UserProvider>(context).user;
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: _appBar(),
      body: Center(
        child: HomeScreenItems.elementAt(widget.selectedIndex),
      ),
      drawer: _customDrawer(userProvider.name, userProvider.email),
      bottomNavigationBar: _navBar(),
    );
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      actions: [
        widget.selectedIndex == 3
            ? isMe
                ? Center(
                    child: Padding(
                      padding: EdgeInsets.only(right: _deviceWidth * 0.05),
                      child: GestureDetector(
                        onTap: () {},
                        child: const Text(
                          "Edit Profile",
                          style: TextStyle(
                              color: grey,
                              fontSize: 17,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  )
                : Text("")
            : const Text("")
      ],
      backgroundColor: white,
      elevation: 0,
      title: ValueListenableBuilder(
        valueListenable: title,
        builder: (BuildContext context, String value, _) {
          return Text(
            value,
            style: const TextStyle(
                color: black, fontWeight: FontWeight.w400, fontSize: 20),
          );
        },
      ),
    );
  }

  Widget _customDrawer(String name, String email) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.only(left: _deviceWidth * 0.04),
        children: [
          _drawerHeader(name, email),
          SizedBox(
            height: _deviceHeight * 0.02,
          ),
          _drawerItems(
              () => () {
                    Navigator.pop(context);
                    _onItemTapped(1);
                  }(),
              "Add New Post",
              "assets/images/add.png"),
          SizedBox(
            height: _deviceHeight * 0.02,
          ),
          _drawerItems(
              () => () {
                    _onItemTapped(2);
                    Navigator.pop(context);
                  }(),
              "Messages",
              "assets/images/messages.png"),
          SizedBox(
            height: _deviceHeight * 0.02,
          ),
          _drawerItems(() => () {}, "FAQs", "assets/images/faqs.png"),
          SizedBox(
            height: _deviceHeight * 0.02,
          ),
          _drawerItems(
              () => () {}, "Terms & Conditions", "assets/images/terms.png"),
          SizedBox(
            height: _deviceHeight * 0.02,
          ),
          _drawerItems(() => () {}, "Contact Us", "assets/images/contact.png"),
          SizedBox(
            height: _deviceHeight * 0.02,
          ),
          _drawerItems(() => () {}, "Languages", "assets/images/language.png"),
          SizedBox(
            height: _deviceHeight * 0.02,
          ),
          _drawerItems(() => () {}, "Logout", "assets/images/logout.png"),
        ],
      ),
    );
  }

  Widget _navBar() {
    return BottomNavigationBar(
      iconSize: 30,
      unselectedItemColor: grey,
      showUnselectedLabels: true,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'home'),
        BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline), label: 'New Post'),
        BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.chat_bubble), label: 'Messages'),
        BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined), label: 'Profile'),
      ],
      currentIndex: widget.selectedIndex == 4 ? 3 : widget.selectedIndex,
      selectedItemColor: primary,
      onTap: _onItemTapped,
    );
  }

  Widget _drawerHeader(String name, String email) {
    return DrawerHeader(
      child: Center(
        child: Row(
          children: [
            const CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage("https://i.pravatar.cc/300"),
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
                  email,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 11, color: grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _drawerItems(Function()? ontap, String Title, String icon) {
    return GestureDetector(
      onTap: ontap,
      child: Row(
        children: [
          Image.asset(
            icon,
            width: 25,
          ),
          SizedBox(
            width: _deviceWidth * 0.02,
          ),
          Text(
            Title,
            style: const TextStyle(
                fontSize: 15, fontWeight: FontWeight.w500, color: grey),
          ),
        ],
      ),
    );
  }
}
