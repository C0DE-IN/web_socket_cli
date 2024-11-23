import 'dart:async';
import 'dart:io';
import 'websocket_base.dart';

class WebSocketIO extends WebSocketBase {
  final WebSocket _socket;

  WebSocketIO._(this._socket);

  static Future<WebSocketBase> connect(String url,
      {Map<String, String>? headers, bool followRedirects = true}) async {
    final uri = Uri.parse(url);
    final client = HttpClient();

    HttpClientRequest request = await client.openUrl('GET', uri);

    // Add headers if provided
    headers?.forEach((key, value) {
      request.headers.add(key, value);
    });

    HttpClientResponse response = await request.close();

    // Handle redirects manually if `followRedirects` is true
    if (followRedirects && response.isRedirect) {
      final redirectUri =
          Uri.parse(response.headers.value(HttpHeaders.locationHeader)!);
      return connect(redirectUri.toString(),
          headers: headers, followRedirects: followRedirects);
    }

    // Validate WebSocket upgrade response
    if (response.statusCode != 101 ||
        !response.headers
            .value('connection')!
            .toLowerCase()
            .contains('upgrade')) {
      throw WebSocketException(
          'Failed to connect, status: ${response.statusCode}');
    }

    // Detach the socket and create the WebSocket
    final socket = await WebSocket.fromUpgradedSocket(
      await response.detachSocket(),
      protocol: null,
      serverSide: false,
    );

    return WebSocketIO._(socket);
  }

  @override
  Stream<dynamic> get messages => _socket.asBroadcastStream();

  @override
  void send(dynamic data) {
    if (data is String) {
      _socket.add(data);
    } else if (data is List<int>) {
      _socket.add(data);
    } else {
      throw ArgumentError('Unsupported data type');
    }
  }

  @override
  void close([int? code, String? reason]) => _socket.close(code, reason);
}
