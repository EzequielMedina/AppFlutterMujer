import 'package:appcuidatemujer/utils/socket_client.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: Text("lalal")),
            Obx(() {
              final String? typingUser = SocketClient.instance.typingUsers;
              if (typingUser != null) {
                return Text(
                  "$typingUser is typing...",
                  style: TextStyle(
                    color: Colors.black26,
                  ),
                );
              } else {
                return Container(height: 0,);
              }
            }),
            CupertinoTextField(
              onChanged: SocketClient.instance.onInputChanged,
            ),
          ],
        ),
      ),
    );
  }
}
