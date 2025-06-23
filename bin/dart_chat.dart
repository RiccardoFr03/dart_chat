import 'dart:io';
import 'package:dart_chat/dart_chat.dart' as dart_chat;

/// CLI entry point. Prompts the user to act as server or client.
Future<void> main() async {
  String? choice;
  do {
    stdout.writeln('Welcome to Dart Chat');
    stdout.writeln('S: Start new chat (server)');
    stdout.writeln('C: Join chat (client)');
    choice = stdin.readLineSync();
  } while (choice != 'C' && choice != 'S');

  if (choice == 'S') {
    await dart_chat.handleServer();
  } else {
    await dart_chat.handleClient();
  }
}
