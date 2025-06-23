import 'dart:async';
import 'dart:io';
import 'package:dart_chat/controllers/server_controller.dart';

/// Starts the server, waits for one client and mirrors stdin ↔ client streams.
Future<void> handleServer() async {
  final server = ServerController();

  try {
    await server.bind();
    stdout.writeln('Server listening on ${server.address}:${server.port}');

    server.onMessage.listen(
      (msg) => stdout.writeln('Client: $msg'),
      onError: (e) => stdout.writeln('Receive error: $e'),
      onDone: () => stdout.writeln('Message stream closed'),
    );

    /// begins accepting a client
    server.listen();

    stdout.writeln('Type messages (exit to quit):');

    stdin.asBroadcastStream().listen((data) async {
      final cmd = String.fromCharCodes(data).trim();
      if (cmd == 'exit') {
        await server.disconnect();
        exit(0);
      } else {
        server.sendMessage(cmd);
      }
    });

    await Completer<void>().future;
  } finally {
    await server.disconnect();
  }
}
