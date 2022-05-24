import 'package:appcuidatemujer/data/authetication_client.dart';
import 'package:appcuidatemujer/pages/home_page.dart';
import 'package:appcuidatemujer/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final _autheticationClient = GetIt.instance<AutheticationClient>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkLogin();
    });
  }

  Future<void> checkLogin() async {
    final token = await _autheticationClient.accessToken;
    if (token == null) {
      Navigator.pushReplacementNamed(context, Loginpage.routeName);
      return;
    }
    Navigator.pushReplacementNamed(context, HomePage.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
