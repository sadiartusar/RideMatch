import 'package:flutter/widgets.dart';

import '../core/utils/logger.dart';
import 'app_config.dart';

/// Everything that must happen before the first frame.
/// Firebase, remote config, crash reporting and localisation are wired here
/// once those packages are added.
class AppInitializer {
  AppInitializer._();

  static Future<void> run({
    Environment environment = Environment.development,
  }) async {
    WidgetsFlutterBinding.ensureInitialized();

    AppConfig.environment = environment;
    AppLogger.enabled = AppConfig.enableLogging;

    // await Firebase.initializeApp();

    AppLogger.i('Initialized in ${environment.name}', 'AppInitializer');
  }
}
