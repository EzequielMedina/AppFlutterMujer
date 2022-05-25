import 'package:appcuidatemujer/utils/socket_client.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Chat extends StatefulWidget {
  Chat({Key? key}) : super(key: key);

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              child: Text("lalal")),
            CupertinoTextField(
              onChanged: SocketClient.instance.onInputChanged,
            ),
          ],
        ),
      ),
    );
    
  }
}