import 'package:appcuidatemujer/api/authentication_api.dart';
import 'package:appcuidatemujer/models/authetication_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import '../data/authetication_client.dart';
import '../utils/dialogs.dart';
import '../widgets/Circle.dart';
import '../widgets/input_text.dart';
import 'home_page.dart';

class Loginpage extends StatefulWidget {
  static const routeName = 'LoginPage';
  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  final _authenticationApi = GetIt.instance<AuthenticationApi>();
  final _autheticationClient = GetIt.instance<AutheticationClient>();
  final GlobalKey<FormState> _formkey = GlobalKey();
  String _email = '', _contrasena = '';

  Future<void> _submit() async {
    final isOk = _formkey.currentState?.validate();
    if (isOk == true) {
      ProgressDialog.show(context);
      
      final response = await _authenticationApi.login(
        email: _email,
        password: _contrasena,
      );
      ProgressDialog.dissmiss(context);
      if (response.data != null) {
        AutheticationResponse? res = response.data;
        await _autheticationClient.saveSession(res!);
        Navigator.pushNamedAndRemoveUntil(context, HomePage.routeName,
            (_) => false /*(route)=>route.settings.name=='Perfil'*/);
      } else {
        String errorMessage = "${response.error?.data['error']}";
        if (response.error?.statusCode == -1) {
          errorMessage = "sin conexion a internet";
        }
        Dialogs.alert(context, title: "ERROR", description: errorMessage);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          width: size.width,
          height: size.height,
          child: Stack(
            children: <Widget>[
              Positioned(
                top: -size.width * 0.34,
                right: -size.width * 0.15,
                child: Circle(
                  radius: size.width * 0.45,
                  colorsCircle: const [Colors.pink, Colors.pinkAccent],
                ),
              ),
              Positioned(
                top: -size.width * 0.3,
                left: -size.width * 0.15,
                child: Circle(
                  radius: size.width * 0.35,
                  colorsCircle: const [Colors.orange, Colors.deepOrange],
                ),
              ),
              SingleChildScrollView(
                child: Container(
                    width: size.width,
                    height: size.height,
                    child: SafeArea(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            children: [
                              Container(
                                child: const Icon(
                                  Icons.local_florist_sharp,
                                  color: Colors.pinkAccent,
                                  size: 32,
                                ),
                                width: 90,
                                height: 90,
                                margin: EdgeInsets.only(
                                  top: size.width * 0.3,
                                ),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black87,
                                        blurRadius: 25,
                                      )
                                    ]),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              const Text(
                                "Bienvenido\n de nuevo",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w300),
                              ),
                            ],
                          ),
                          Form(
                            child: Column(
                              children: [
                                ConstrainedBox(
                                    constraints: const BoxConstraints(
                                      maxWidth: 350,
                                      minWidth: 350,
                                    ),
                                    child: Form(
                                      key: _formkey,
                                      child: Column(
                                        children: [
                                          InputText(
                                            obscureText: false,
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            label: "EMAIL",
                                            onChanged: (text) {
                                              _email = text;
                                            },
                                            validate: (text) {
                                              return text;
                                            },
                                          ),
                                          const SizedBox(height: 30),
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                vertical: 5),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: InputText(
                                                    keyboardType:
                                                        TextInputType.text,
                                                    obscureText: true,
                                                    label: "CONTRASEÑA",
                                                    onChanged: (text) {
                                                      _contrasena = text;
                                                    },
                                                    validate: (text) {
                                                      return text;
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            child: CupertinoButton(
                                              alignment: Alignment.topLeft,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 17),
                                              onPressed: () {},
                                              child: Text(
                                                "Restablecer",
                                                style: TextStyle(
                                                    color: Colors.pinkAccent,
                                                    fontSize: 17,
                                                    decoration: TextDecoration.underline,
                                                    fontWeight: FontWeight.w600),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )),
                                const SizedBox(height: 40),
                                ConstrainedBox(
                                  constraints: const BoxConstraints(
                                    maxWidth: 350,
                                    minWidth: 350,
                                  ),
                                  child: CupertinoButton(
                                    borderRadius: BorderRadius.circular(16),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 17),
                                    color: Colors.pinkAccent,
                                    child: const Text(
                                      "Iniciar Sesion",
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                    onPressed: _submit,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "¿Eres Nuevo?",
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.black54),
                                    ),
                                    CupertinoButton(
                                        child: const Text(
                                          "Registrate",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.pinkAccent),
                                        ),
                                        onPressed: () {
                                          Navigator.pushNamed(
                                              context, 'RegistrarPages');
                                        }),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
