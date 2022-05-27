import 'dart:async';

import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

enum SocketStatus {
  connecting,
  connected,
  joined,
  disconnected,
  error,
}

class SocketClient {
  SocketClient._internal();
  static final SocketClient _instance = SocketClient._internal();
  static SocketClient get instance => _instance;

  RxInt _numUsers = 0.obs;
  RxString _inputText = "".obs;
  Rx<SocketStatus> _status = SocketStatus.connecting.obs;
  RxMap<String, String> _typingUsers = Map<String, String>().obs;

  Rx<SocketStatus> get status => _status;
  RxInt get numUsers => _numUsers;
  String? get typingUsers{
    
    if (_typingUsers.values.length > 0) {
      return _typingUsers.values.last;
    }
    return null;
  }

  IO.Socket? _socket;
  String _nickName = "";
  Worker? _typingWorker;

  void init() {
    debounce(_inputText, (_) {
      _socket?.emit("stop typing");
      _typingWorker = null;
    }, time: Duration(milliseconds: 500));
  }

  void connect() {
    _socket = IO.io(
      'https://socketio-chat-h9jt.herokuapp.com',
      <String, dynamic>{
        'transports': ['websocket'], // for Flutter or Dart VM
      },
    );
    _socket?.on('connect', (_) {
      _status.value = SocketStatus.connected;
    });
    _socket?.on('connect_error', (_) {
      _status.value = SocketStatus.error;
    });
    _socket?.on('disconnect', (_) {
      _status.value = SocketStatus.disconnected;
    });
    _socket?.on('login', (data) {
      final int numUsers = data['numUsers'];
      _numUsers.value = numUsers;
      _status.value = SocketStatus.joined;
    });
    _socket?.on('user joined', (data) {
      _numUsers.value = data['numUsers'] as int;
    });
    _socket?.on("typing", (data) {
      final String username = data['username'];
      _typingUsers[username] = username;
    });
    _socket?.on("stop typing", (data) {
      final String username = data['username'];
      _typingUsers.remove(username);
    });
  }

  void joinToChat(String nickName) {
    _nickName = nickName;
    _socket?.emit("add user", nickName);
  }

  void disconnect() {
    _socket?.disconnect();
    _socket = null;
  }

  void onInputChanged(String text) {
    if (_typingWorker == null) {
      _typingWorker = once(_inputText, (_) {});
      _socket?.emit('typing');
    }
    _inputText.value = text;
  }
}
