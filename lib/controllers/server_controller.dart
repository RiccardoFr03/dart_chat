import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

/// Handles the TCP server:
///  • binds on localhost:3000
///  • waits for a single client
///  • exposes a stream of incoming messages
///  • lets the UI send outbound messages
///  • cleans up sockets and subscriptions when `disconnect()` is called
class ServerController {
  late ServerSocket _server; // The listening socket
  late Socket _client; // Single connected client

  final _messageController = StreamController<String>();

  late StreamSubscription<Socket> _socketSub; // Accept subscription
  StreamSubscription<Uint8List>? _dataSub; // Data subscription

  Future<void> bind() async {
    _server = await ServerSocket.bind(InternetAddress.loopbackIPv4, 3000);
  }

  /// Starts accepting a single client connection.
  void listen() {
    _socketSub = _server.listen(_onConnected);
  }

  /// Sends a text message to the connected client.
  void sendMessage(String message) => _client.write(message);

  /// Shuts down server, client socket and subscriptions.
  Future<void> disconnect() async {
    await _server.close();
    await _client.close();
    await _socketSub.cancel();
    await _dataSub?.cancel();
  }

  // Convenience getters
  String get address => _server.address.address;
  int get port => _server.port;
  Stream<String> get onMessage => _messageController.stream;

  /* ---------- private helpers ---------- */

  void _onConnected(Socket client) {
    _client = client;
    _dataSub = client.listen(_onMessage, onError: _onDisconnected);
  }

  void _onMessage(Uint8List data) => _messageController.add(String.fromCharCodes(data));

  Future<void> _onDisconnected(Object _) async {
    await _client.close();
    await _dataSub?.cancel();
  }
}
