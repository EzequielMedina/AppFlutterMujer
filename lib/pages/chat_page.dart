import 'dart:io';
import 'package:get/state_manager.dart';
import 'package:appcuidatemujer/utils/socket_client.dart';
import 'package:appcuidatemujer/widgets/chat.dart';
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
    SocketClient.instance.init();
    SocketClient.instance.connect();
  }

  void disponse() {
    SocketClient.instance.disconnect();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() {
          final users = SocketClient.instance.numUsers;
          return Center(child: Text("users: (${users.value})"));
        }),
      ),
      body: Obx(() {
        final status = SocketClient.instance.status;
        if (status.value == SocketStatus.connecting) {
          return const Center(child: CircularProgressIndicator());
        } else if (status.value == SocketStatus.connected) {
          return NicknameForm();
        } else if (status.value == SocketStatus.joined) {
          return Chat();
        } else {
          return const Center(
            child: Text("disconnected"),
          );
        }
      }),
    );
  }
}
