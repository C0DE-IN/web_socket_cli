library websocket_client;

// import 'dart:io' as io;
// import 'dart:html' as html if (dart.library.html) 'src/websocket_web.dart';
import 'src/websocket_base.dart' if (dart.library.io) 'src/websocket_io.dart';

/// WebSocket Client with support for headers and followRedirects
class WebSocketClient {
  late final WebSocketBase _client;

  WebSocketClient(String url,
      {Map<String, String>? headers, bool followRedirects = true}) {
    _client = WebSocketBase.connect(url,
        headers: headers, followRedirects: followRedirects);
  }

  Stream<dynamic> get messages => _client.messages;

  void send(dynamic data) => _client.send(data);

  void close([int? code, String? reason]) => _client.close(code, reason);
}
