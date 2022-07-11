import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/socket_client.dart';

class InputChat extends StatefulWidget {
  const InputChat({Key? key}) : super(key: key);

  @override
  State<InputChat> createState() => _InputChatState();
}

class _InputChatState extends State<InputChat> {
  final TextEditingController _controller = TextEditingController();
  void disponse(){
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CupertinoTextField(
            controller: _controller,
            onChanged: SocketClient.instance.onInputChanged,
          ),
        ),
        CupertinoButton(child: Icon(Icons.send), onPressed: (){
          final send = SocketClient.instance.sendMessage();
          if(send){
            _controller.text = "";
          }
        })
      ],
    );
  }
}
