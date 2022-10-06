import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wiin/consts/colors.dart';
import 'package:wiin/pages/HomePage.dart';
import 'package:wiin/pages/login_page.dart';
import 'package:wiin/pages/register_page.dart';
import 'package:wiin/pages/splash_page.dart';
import 'package:wiin/providers/user_provider.dart';
import 'package:wiin/services/auth_services.dart';

void main() {
  runApp(SplashPage(onInitialisationComplete: () {
    runApp(MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => UserProvider())
    ], child: MyApp()));
  }));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthServices authServices = AuthServices();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    authServices.getUserData(context: context);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            primarySwatch: Colors.blue,
            iconTheme: IconThemeData(color: Colors.black),
            scaffoldBackgroundColor: white),
        home: Provider.of<UserProvider>(context, listen: false)
                .user
                .token
                .isNotEmpty
            ? HomePage(
                selectedIndex: 0,
              )
            : const LoginPage());
  }
}
