abstract class WebSocketBase {
  /// Connects to the WebSocket server.
  static WebSocketBase connect(String url,
      {Map<String, String>? headers, bool followRedirects = true}) {
    throw UnsupportedError('Platform not supported');
  }

  /// Stream of incoming messages
  Stream<dynamic> get messages;

  /// Sends data to the WebSocket server
  void send(dynamic data);

  /// Closes the WebSocket connection
  void close([int? code, String? reason]);
}
