import 'dart:io';
import 'dart:typed_data';
import 'websocket_base.dart';
import 'websocket_exception.dart'; // Import the custom exception

class WebSocketIO extends WebSocketBase {
  final WebSocket _socket;

  WebSocketIO._(this._socket);

  static Future<WebSocketBase> connect(String url,
      {Map<String, String>? headers, bool followRedirects = true}) async {
    final uri = Uri.parse(url);
    final client = HttpClient();

    HttpClientRequest request = await client.openUrl('GET', uri);
    headers?.forEach((key, value) {
      request.headers.add(key, value);
    });

    HttpClientResponse response = await request.close();

    if (followRedirects && response.isRedirect) {
      final redirectUri =
          Uri.parse(response.headers.value(HttpHeaders.locationHeader)!);
      return connect(redirectUri.toString(),
          headers: headers, followRedirects: followRedirects);
    }

    if (response.statusCode != 101) {
      throw WebSocketException(
          'Failed to connect, status: ${response.statusCode}');
    }

    final socket = await WebSocket.fromUpgradedSocket(
      await response.detachSocket(),
      protocol: null,
      serverSide: false,
    );

    return WebSocketIO._(socket);
  }

  @override
  Stream<dynamic> get messages => _socket.map((event) {
        if (event is List<int>) {
          return Uint8List.fromList(event); // Return binary data as Uint8List
        } else if (event is String) {
          return event; // Handle text messages
        }
        throw UnsupportedError('Unsupported message type');
      });

  @override
  void send(dynamic data) {
    if (data is String) {
      _socket.add(data); // Send text data
    } else if (data is List<int>) {
      _socket.add(data); // Send binary data
    } else {
      throw ArgumentError('Unsupported data type');
    }
  }

  @override
  void close([int? code, String? reason]) => _socket.close(code, reason);
}
