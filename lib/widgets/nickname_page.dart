import 'package:appcuidatemujer/utils/socket_client.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NicknameForm extends StatefulWidget {
  NicknameForm({Key? key}) : super(key: key);

  @override
  State<NicknameForm> createState() => _NicknameFormState();
}

class _NicknameFormState extends State<NicknameForm> {
  String _nickName = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Text("cual es tu nick name ?",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          CupertinoTextField(
            placeholder: "inserta tu nick name",
            textAlign: TextAlign.center,
            onChanged: (text){
              _nickName = text;
            },
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: CupertinoButton(
              child: Text("join to chat"),
              color: Colors.blue,
              onPressed: () {
                if(_nickName.trim().length > 0){
                  SocketClient.instance.joinToChat(_nickName);
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
