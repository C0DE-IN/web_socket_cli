import 'dart:async';
import 'dart:html';
import 'websocket_base.dart';

class WebSocketWeb extends WebSocketBase {
  final WebSocket _socket;

  WebSocketWeb._(this._socket);

  static WebSocketBase connect(String url,
      {Map<String, String>? headers, bool followRedirects = true}) {
    // Headers and followRedirects are not supported directly by WebSocket API in web
    final socket = WebSocket(url);

    return WebSocketWeb._(socket);
  }

  @override
  Stream<dynamic> get messages => _socket.onMessage.map((event) => event.data);

  @override
  void send(dynamic data) {
    if (data is String || data is List<int>) {
      _socket.send(data);
    } else {
      throw ArgumentError('Unsupported data type');
    }
  }

  @override
  void close([int? code, String? reason]) => _socket.close(code, reason);
}
