
import 'package:appcuidatemujer/helpers/dependency_injection.dart';
import 'package:appcuidatemujer/pages/RegistrarPages.dart';
import 'package:appcuidatemujer/pages/chat_page.dart';
import 'package:appcuidatemujer/pages/home_page.dart';
import 'package:appcuidatemujer/pages/splash_pages.dart';

import 'package:flutter/material.dart';
import 'pages/login.dart';
void main() {
  DependencyInjection.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: SplashPage(),//HomePage(), inicio de sesion
      routes: {
        RegistrarPages.routeName:(_) => RegistrarPages(),
        Loginpage.routeName:(_) => Loginpage(),
        HomePage.routeName:(_) => HomePage(),
        ChatPages.routeName:(_) => ChatPages(),
      },
    );
  }
}
