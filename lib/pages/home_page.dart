import 'package:appcuidatemujer/api/account_api.dart';
import 'package:appcuidatemujer/data/authetication_client.dart';
import 'package:appcuidatemujer/models/user.dart';
import 'package:appcuidatemujer/pages/login.dart';
import 'package:appcuidatemujer/utils/socket_client.dart';
import 'package:appcuidatemujer/widgets/avatarBottom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../widgets/Circle.dart';

class HomePage extends StatefulWidget {
  static const routeName = "homePage";
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AutheticationClient _autheticationClient =
      GetIt.instance<AutheticationClient>();

  final AccountApi _accountApi = GetIt.instance<AccountApi>();
  User? _user;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadUser();
    });
  }

  Future<void> _loadUser() async {
    final response = await _accountApi.getUserInfo();
    if (response.data != null) {
      print(response.data!.email);
      _user = response.data;
      setState(() {});
    }
  }

  Future<void> _signOut() async {
    await _autheticationClient.singOut();
    Navigator.pushNamedAndRemoveUntil(
      context,
      Loginpage.routeName,
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
      width: size.width,
      height: size.height,
      child: Stack(children: [
        Positioned(
            child: Container(
          height: size.width * 0.6,
          child: Image(
            fit: BoxFit.cover,
            image: const AssetImage('assest/descarga.jpg'),
          ),
        )),
        Positioned(
          bottom: 0,
          top: 150,
          child: Container(
            height: size.height,
            child: Material(
              elevation: 10,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              child: SingleChildScrollView(
                child: SizedBox(
                  width: size.width,
                  height: size.height,
                  child: Stack(
                    children: [
                      Positioned(
                        top: size.height * 0.15,
                        left: size.width * 0.35,
                        child: Column(children: [
                          if (_user == null) const CircularProgressIndicator(),
                          if (_user != null)
                            Text(_user!.usuario,
                                style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                        ]),
                      ),
                      const SizedBox(
                        height: 17,
                      ),
                      Positioned(
                        top: size.height * 0.3,
                        left: size.width * 0.01,
                        child: SizedBox(
                          width: size.width / 2.1,
                          height: size.height * 0.1,
                          child: const buttonNavigator(
                              navigator: 'chatPages', texto: 'chat'),
                        ),
                      ),
                      const SizedBox(
                        height: 17,
                      ),
                      Positioned(
                        top: size.height * 0.3,
                        right: size.width * 0.01,
                        child: SizedBox(
                          width: size.width / 2.1,
                          height: size.height * 0.1,
                          child: Material(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            shadowColor: Color.fromARGB(255, 3, 169, 190),
                            child: CupertinoButton(
                              color: Color.fromARGB(255, 2, 214, 241),
                              alignment: Alignment.topRight,
                              onPressed: _signOut,
                              child: Center(
                                  child: Text(
                                "Salir",
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              )),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
            top: size.width * 0.2,
            left: size.width * 0.3,
            child: avatarBottom()),
      ]),
    ));
  }
}

class buttonNavigator extends StatelessWidget {
  final String navigator;
  final String texto;
  const buttonNavigator({
    Key? key,
    required this.navigator,
    required this.texto,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      shadowColor: Color.fromARGB(255, 3, 169, 190),
      child: CupertinoButton(
        color: Color.fromARGB(255, 2, 214, 241),
        alignment: Alignment.topRight,
        onPressed: () {
          Navigator.pushNamed(context, navigator);
        },
        child: Center(
            child: Text(
          texto,
          style: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        )),
      ),
    );
  }
}
