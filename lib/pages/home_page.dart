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
      SocketClient.instance.connect();
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
    SocketClient.instance.disconnect();
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
          color: Colors.amberAccent,
          height: size.width * 0.6,
          child: Image(
            fit: BoxFit.cover,
            image: const AssetImage('assest/descarga.jpg'),
          ),
        )),
        Positioned(
          top: size.width * 0.42,
          right: size.height * 0.02,
          child: Text(''), // avatarBottom(),
        ),
        Positioned(
          bottom: -size.width * 0.34,
          left: -size.width * 0.15,
          child: Circle(
            radius: size.width * 0.45,
            colorsCircle: const [
              Colors.lightGreenAccent,
              Color.fromARGB(255, 113, 238, 177)
            ],
          ),
        ),
        Positioned(
          bottom: -size.width * 0.3,
          right: -size.width * 0.15,
          child: Circle(
            radius: size.width * 0.35,
            colorsCircle: const [
              Colors.pinkAccent,
              Color.fromARGB(255, 248, 187, 208)
            ],
          ),
        ),
        SingleChildScrollView(
          child: SizedBox(
            width: size.width,
            height: size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Center(
                  child: Text("Bienvenido"),
                ),
                if (_user == null) const CircularProgressIndicator(),
                if (_user != null)
                  Column(
                    children: [Text(_user!.email), Text(_user!.usuario)],
                  ),
                const SizedBox(
                  height: 17,
                ),
                CupertinoButton(
                  color: Colors.cyan[400],
                  alignment: Alignment.topRight,
                  onPressed: () {
                    Navigator.pushNamed(context, 'chatPages');
                  },
                  child: const Text("Ingresar al chat"),
                ),
                const SizedBox(
                  height: 17,
                ),
                CupertinoButton(
                  color: Colors.cyan[400],
                  alignment: Alignment.topRight,
                  onPressed: _signOut,
                  child: const Text("cerrar session"),
                ),
              ],
            ),
          ),
        ),
      ]),
    ));
  }
}
