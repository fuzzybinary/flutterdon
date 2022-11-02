import 'package:flutter/foundation.dart';

class PlatformUtils {
  static bool get isDesktop {
    if (kIsWeb) return false;

    return [
      TargetPlatform.windows,
      TargetPlatform.linux,
      TargetPlatform.macOS,
    ].contains(defaultTargetPlatform);
  }
}
