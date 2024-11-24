import 'websocket_base.dart';

Future<WebSocketBase> getWebSocketImplementation(String url,
    {Map<String, String>? headers, bool followRedirects = true}) {
  return WebSocketPlatformStub.connect(url,
      headers: headers, followRedirects: followRedirects);
}

class WebSocketPlatformStub extends WebSocketBase {
  // Ensure the connect method is defined, even if it's just a stub
  static Future<WebSocketBase> connect(String url,
      {Map<String, String>? headers, bool followRedirects = true}) async {
    // Return a WebSocketPlatformStub instance to indicate that it's unsupported
    return WebSocketPlatformStub();
  }

  @override
  Stream<dynamic> get messages =>
      Stream.error(UnsupportedError('Platform not supported'));

  @override
  void send(dynamic data) {
    throw UnsupportedError('Platform not supported');
  }

  @override
  void close([int? code, String? reason]) {
    throw UnsupportedError('Platform not supported');
  }
}
