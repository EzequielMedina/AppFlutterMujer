import 'dart:convert';

import 'package:appcuidatemujer/utils/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import '../api/authentication_api.dart';
import '../data/authetication_client.dart';
import '../models/authetication_response.dart';
import '../widgets/Circle.dart';
import '../widgets/avatarBottom.dart';
import '../widgets/input_text.dart';
import 'home_page.dart';

class RegistrarPages extends StatefulWidget {
  static const routeName = 'RegistrarPages';
  @override
  State<RegistrarPages> createState() => _RegistrarPagesState();
}

class _RegistrarPagesState extends State<RegistrarPages> {
  final _autheticationClient = GetIt.instance<AutheticationClient>();
  final _authenticationApi = GetIt.instance<AuthenticationApi>();
  final GlobalKey<FormState> _formkey = GlobalKey();
  String _email = '', _contrasena = '', _usuario = '';

  Future<void> _submit() async {
    final isOk = _formkey.currentState?.validate();

    if (isOk == true) {
      //ProgressDialog.show(context);
      
      final response = await _authenticationApi.register(
        usuario: _usuario,
        email: _email,
        password: _contrasena,
      );
      ProgressDialog.dissmiss(context);
      if (response.data != null) {
        AutheticationResponse? res = response.data;
        await _autheticationClient.saveSession(res!);
        Navigator.pushNamedAndRemoveUntil(context, HomePage.routeName, (_) => false/*(route)=>route.settings.name=='Perfil'*/);
        
      } else {
        String errorMessage;
        if(response.error?.statusCode == -1){
          errorMessage = "sin conexion a internet";
          
        }else{
          errorMessage = "Email ya existente\n${response.error?.data['error']}";
        }
        Dialogs.alert(context, title: "ERROR", description: errorMessage);
        ProgressDialog.dissmiss(context);
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
                left: -size.width * 0.15,
                child: Circle(
                  radius: size.width * 0.45,
                  colorsCircle: const [Colors.orange, Colors.deepOrange],
                ),
              ),
              Positioned(
                top: -size.width * 0.3,
                right: -size.width * 0.15,
                child: Circle(
                  radius: size.width * 0.35,
                  colorsCircle: const [Colors.pink, Colors.pinkAccent],
                ),
              ),
              Positioned(
                  left: 15,
                  top: 25,
                  child: SafeArea(
                    child: CupertinoButton(
                      color: Colors.black26,
                      padding: const EdgeInsets.all(10),
                      borderRadius: BorderRadius.circular(30),
                      child: const Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  )),
              SingleChildScrollView(
                child: Container(
                    width: size.width,
                    height: size.height,
                    child: SafeArea(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            children: const [
                              SizedBox(
                                height: 30,
                              ),
                              Text(
                                "Hola\nGracias por Registrarte",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              avatarBottom(),
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
                                            label: "USUARIO",
                                            onChanged: (text) {
                                              _usuario = text;
                                              
                                            },
                                            validate: (text) {
                                              return text;
                                            },
                                          ),
                                          const SizedBox(height: 30),
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
                                          InputText(
                                            
                                            keyboardType: TextInputType.text,
                                            obscureText: true,
                                            label: "CONTRASEÑA",
                                            onChanged: (text) {
                                              _contrasena = text;
                                            },
                                            validate: (text) {
                                              return text;
                                            },
                                          ),
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
                                    padding: const EdgeInsets.symmetric(vertical: 17),
                                    color: Colors.pinkAccent,
                                    child: const Text(
                                      "Registrarse",
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
                                      "¿Ya Tienes Cuenta?",
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.black54),
                                    ),
                                    CupertinoButton(
                                        child: const Text(
                                          "Iniciar Sesion",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.pinkAccent),
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
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
