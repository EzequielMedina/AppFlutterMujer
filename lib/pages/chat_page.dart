import 'dart:io';

import 'package:appcuidatemujer/utils/socket_client.dart';
import 'package:appcuidatemujer/widgets/nickname_page.dart';
import 'package:flutter/material.dart';

class ChatPages extends StatefulWidget {
   static const routeName = "chatPages";
  ChatPages({Key? key}) : super(key: key);

  @override
  State<ChatPages> createState() => _ChatPagesState();
}

class _ChatPagesState extends State<ChatPages> {
  @override
  void initState() {
    super.initState();
    SocketClient.instance.connect();
  }

  void disponse() {
    SocketClient.instance.disconnect();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder<SocketStatus>(
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data == SocketStatus.connecting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.data == SocketStatus.connected) {
              return NicknameForm();
            }else{
              return const Center(
                child: Text("disconnected"),
              );
            }
          }
          return const Center(
            child: Text("Error"),
          );
        },
        initialData: SocketStatus.connecting,
        stream: SocketClient.instance.status,
      ),
    );
  }
}
