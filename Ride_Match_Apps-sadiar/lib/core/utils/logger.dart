import 'package:flutter/foundation.dart';

class AppLogger {
  AppLogger._();

  /// Set by `app/app_initializer.dart`. Kept here so `core/` owns no
  /// environment knowledge of its own.
  static bool enabled = kDebugMode;

  static void d(String message, [String tag = 'App']) {
    if (!enabled) return;
    debugPrint('[$tag] $message');
  }

  static void i(String message, [String tag = 'App']) {
    if (!enabled) return;
    debugPrint('[$tag] INFO: $message');
  }

  static void e(String message, [Object? error, String tag = 'App']) {
    if (!enabled) return;
    debugPrint('[$tag] ERROR: $message');
    if (error != null) {
      debugPrint('[$tag] $error');
    }
  }
}
