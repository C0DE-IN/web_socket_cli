import 'websocket_base.dart';
import 'websocket_web.dart'; // Your Web implementation

Future<WebSocketBase> getWebSocketImplementation(String url,
    {Map<String, String>? headers, bool followRedirects = true}) {
  return WebSocketWeb.connect(url,
      headers: headers, followRedirects: followRedirects);
}


// import 'dart:html';
// import 'dart:typed_data';
// import 'websocket_base.dart';

// class WebSocketPlatformWeb extends WebSocketBase {
//   final WebSocket _socket;

//   WebSocketPlatformWeb._(this._socket);

//   static WebSocketBase connect(String url,
//       {Map<String, String>? headers, bool followRedirects = true}) {
//     final socket = WebSocket(url);
//     socket.binaryType = 'arraybuffer'; // Set binaryType for binary data

//     return WebSocketPlatformWeb._(socket);
//   }

//   @override
//   Stream<dynamic> get messages => _socket.onMessage.map((event) {
//         if (event.data is ByteBuffer) {
//           // Convert ArrayBuffer to Uint8List
//           return Uint8List.view(event.data as ByteBuffer);
//         } else if (event.data is String) {
//           return event.data; // Handle text messages
//         }
//         throw UnsupportedError('Unsupported message type');
//       });

//   @override
//   void send(dynamic data) {
//     if (data is String) {
//       _socket.send(data); // Send text data
//     } else if (data is List<int>) {
//       _socket.send(data); // Send binary data
//     } else {
//       throw ArgumentError('Unsupported data type');
//     }
//   }

//   @override
//   void close([int? code, String? reason]) => _socket.close(code, reason);
// }
