class WebSocketException implements Exception {
  final String message;

  WebSocketException(this.message);

  @override
  String toString() => "WebSocketException: $message";
}
