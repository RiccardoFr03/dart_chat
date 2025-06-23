# 🗨️ Dart Chat

**Dart Chat** is a lightweight showcase project that builds a *point-to-point TCP chat* (server ↔ client) using only the Dart standard library (`dart:io`).  
The goal is to demonstrate how to open raw sockets, manage asynchronous streams, and exchange real-time text messages from the command line.

---

## ✨ Features

- **TCP server** bound to `localhost:3000` (created with `ServerSocket`).
- **TCP client** that automatically connects to the local server.
- Fully **asynchronous I/O** through `Stream` and `StreamController`.
- **Bidirectional messaging**: anything typed in one terminal is delivered immediately to the other.
- **`exit` command** to disconnect and close sockets/streams gracefully.
- **Graceful shutdown** of every handle (`Socket`, `ServerSocket`, subscriptions).
- Minimal **CLI wizard**  
  - Press `S` to act as *Server* or `C` to act as *Client*.  
  - Console echo with `"Server:"` or `"Client:"` prefixes.
- Runs on **Windows, macOS, and Linux** (Dart SDK is the only requirement).
- Modular project layout (controllers + entry-points) ready for extension.

---

## 🚀 Quick Start (60 seconds)

1. **Prerequisite** – make sure the **Dart SDK ≥ 3.0** is installed.
2. **Clone** the repository and fetch dependencies:
git clone https://github.com/your-user/dart_chat.git
cd dart_chat
dart pub get # no external packages yet, but good practice
3. Open **two terminal windows** inside the project folder.
Terminal 1 — START THE SERVER  
dart run bin/main.dart
When prompted, press “S” + Enter to Start new chat (server)
Terminal 2 — JOIN AS CLIENT  
dart run bin/main.dart
When prompted, press “C” + Enter to Join chat (client)
4. **Chat away!**  
- Every line you type in one terminal appears instantly in the other.  
- Type **`exit`** and press Enter to close the session.

> Note: the demo is configured for local use. To test across a LAN, change the IP in the controllers or make it a CLI parameter.

---

## 📁 Code Layout

| Path                                    | Responsibility                                                  |
|-----------------------------------------|-----------------------------------------------------------------|
| `lib/controllers/server_controller.dart`| Binding, accepting a client, sending/receiving on the server    |
| `lib/controllers/client_controller.dart`| Connecting to the server, handling messages on the client       |
| `bin/handle_server.dart`                | CLI flow built around `ServerController`                        |
| `bin/handle_client.dart`                | CLI flow built around `ClientController`                        |
| `bin/main.dart`                         | Entry point that asks whether to run as server or client        |

---

## 🛣️ Roadmap

- Support **multiple clients** simultaneously (broadcast).
- **Host/port** passed as CLI arguments.
- TLS/SSL encryption.
- GUI front-end with **Flutter** or a text UI (TUI).

---

## 📄 License

Released under the **MIT License** – feel free to copy, modify, and share with attribution.
