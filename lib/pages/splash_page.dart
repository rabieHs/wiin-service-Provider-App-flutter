import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class SplashPage extends StatefulWidget {
  final VoidCallback onInitialisationComplete;
  const SplashPage({Key? key, required this.onInitialisationComplete})
      : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 5))
        .then((_) => widget.onInitialisationComplete());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Chatify', home: Splash());
  }
}

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  late double _deviceHeight;
  late double _deviceWidth;
  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color.fromRGBO(238, 241, 248, 1),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: _deviceWidth * 0.2, vertical: _deviceHeight * 0.1),
        child: Container(
            margin: EdgeInsets.only(top: _deviceHeight * 0.3),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset("assets/images/logo.png"),
                Container(
                    height: _deviceWidth * 0.4,
                    width: _deviceWidth * 0.4,
                    child: Image.asset(
                      "assets/images/loading2.gif",
                      width: 4,
                      scale: 1,
                    ))
              ],
            )),
      ),
    );
  }
}
