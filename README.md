# Web_Socket_Cli Package

A cross-platform WebSocket client for Flutter and Dart applications. Supports headers, redirects, and works on web, iOS, and Android.

## Features
- Cross-platform support (web, iOS, Android).
- Custom headers for WebSocket connections.
- Redirect handling (on supported platforms).

## Installation
Add the following to your `pubspec.yaml`:
```
dependencies:
  web_socket_cli: ^0.0.9
```

Run flutter pub get or dart pub get to install the package.

## Usage
```
import 'package:web_socket_cli/web_socket_cli.dart';
import 'dart:typed_data';

void main() {
  final client = WebSocketClient('wss://example.com/ws');

  client.messages.listen((message) {
    if (message is Uint8List) {
      // Handle binary data
      print('Received binary message: ${message.length} bytes');
      // Decode the binary data at the application level
      decodeBinaryMessage(message);
    } else if (message is String) {
      // Handle text messages
      print('Received text message: $message');
    }
  });

  // Sending binary data
  final binaryData = Uint8List.fromList([1, 2, 3, 4, 5]);
  client.send(binaryData);

  // Sending text data
  client.send('Hello, WebSocket!');
}

void decodeBinaryMessage(Uint8List data) {
  // Your custom binary data decoding logic
  print('Decoding binary message: $data');
}

```
