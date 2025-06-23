import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

/// Handles the TCP client side:
///  • connects to localhost:3000
///  • exposes a stream of incoming messages
///  • lets the UI send outbound messages
///  • cleans up on `disconnect()`
class ClientController {
  late Socket _socket;

  final _messageController = StreamController<String>();
  late StreamSubscription<Uint8List> _dataSub;

  Future<void> connect() async {
    _socket = await Socket.connect(InternetAddress.loopbackIPv4, 3000);
  }

  Future<void> disconnect() async {
    await _socket.close();
    await _dataSub.cancel();
  }

  /// Starts listening for data coming from the server.
  void listen() {
    _dataSub = _socket.listen(_onMessage);
  }

  /// Sends a text message to the server.
  void sendMessage(String message) => _socket.write(message);

  // Convenience getters
  String get remoteAddress => _socket.remoteAddress.address;
  int get remotePort => _socket.remotePort;
  Stream<String> get onMessage => _messageController.stream;

  void _onMessage(Uint8List data) => _messageController.add(String.fromCharCodes(data));
}
