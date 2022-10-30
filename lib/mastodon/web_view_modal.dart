part of mastodon;

const MethodChannel _channel = MethodChannel('plugins.flutter.io/webmodal');

class WebViewModal {
  final String urlString;

  WebViewModal(this.urlString) {
    final Uri url = Uri.parse(urlString.trimLeft());
    final bool isWebURL = url.scheme == 'http' || url.scheme == 'https';
    if (!isWebURL) {
      throw PlatformException(
          code: 'NOT_A_WEB_SCHEME',
          message: 'To use webview or safariVC, you need to pass'
              'in a web URL. This $urlString is not a web URL.');
    }
  }

  Future present() async {
    return _channel.invokeMethod(
      'present',
      <String, Object>{'url': urlString},
    );
  }

  void close() {
    _channel.invokeMethod('close', {});
  }
}
