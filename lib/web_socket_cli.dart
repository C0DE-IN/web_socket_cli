import 'dart:async';
import 'src/websocket_base.dart';
import 'src/websocket_platform_stub.dart'
    if (dart.library.io) 'src/websocket_platform_io.dart'
    if (dart.library.html) 'src/websocket_platform_web.dart';

class WebSocketCli {
  late final Future<WebSocketBase> _client;

  WebSocketCli(String url,
      {Map<String, String>? headers, bool followRedirects = true}) {
    _client = getWebSocketImplementation(url,
        headers: headers, followRedirects: followRedirects);
  }

  // Await the Future and then access the messages stream using asyncExpand
  Stream<dynamic> get messages =>
      _client.asStream().asyncExpand((client) => client.messages);

  // Await the Future and then call the send method
  void send(dynamic data) async {
    final client = await _client;
    client.send(data);
  }

  // Await the Future and then call the close method
  void close([int? code, String? reason]) async {
    final client = await _client;
    client.close(code, reason);
  }
}
