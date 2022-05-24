import 'dart:async';

import 'package:socket_io_client/socket_io_client.dart' as IO;
enum soquetStatus {
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

  StreamController<soquetStatus> _statusController = StreamController.broadcast();

  Stream<soquetStatus> get status => _statusController.stream;

  IO.Socket? _socket;
  void connect() {
    this._socket = IO.io(
      'https://socketio-chat-h9jt.herokuapp.com',
      <String, dynamic>{
        'transports': ['websocket'], // for Flutter or Dart VM
      },
    );
    _socket?.on('connect', (_) {
      print("conection socket");
      this._statusController.sink.add(soquetStatus.connected);
    });
    _socket?.on('connect_error', (_) {
      print("error $_");
      this._statusController.sink.add(soquetStatus.error);
    });
    _socket?.on('disconnect', (_) {
      print("disconnect $_");
      this._statusController.sink.add(soquetStatus.disconnected);
    });
  }
  

  void disconnect() {
    _socket?.disconnect();
  }


}
