import 'package:flutter/material.dart';

import 'app/app.dart';
import 'app/app_config.dart';
import 'app/app_initializer.dart';

Future<void> main() async {
  // Switch before shipping: development | staging | production
  await AppInitializer.run(environment: Environment.development);

  runApp(const RideMatchApp());
}
