import 'dart:async';
import 'dart:io';
import 'package:dart_chat/controllers/client_controller.dart';

/// Starts a client session: connects, pipes stdin → server and server → stdout.
Future<void> handleClient() async {
  final client = ClientController();

  try {
    await client.connect();
    stdout.writeln('Connected to ${client.remoteAddress}:${client.remotePort}');

    // Listen for messages arriving from the server
    client.onMessage.listen(
      (msg) => stdout.writeln('Server: $msg'),
      onError: (e) => stdout.writeln('Receive error: $e'),
      onDone: () => stdout.writeln('Message stream closed'),
    );

    /// begins reading socket data
    client.listen();

    stdout.writeln('Type messages (exit to quit):');

    /// Read user input from console
    stdin.asBroadcastStream().listen((data) async {
      final cmd = String.fromCharCodes(data).trim();
      if (cmd == 'exit') {
        await client.disconnect();
        exit(0);
      } else {
        client.sendMessage(cmd);
      }
    });

    /// Keep process alive
    await Completer<void>().future;
  } finally {
    await client.disconnect();
  }
}
