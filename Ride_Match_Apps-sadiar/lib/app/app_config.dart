enum Environment { development, staging, production }

/// Environment-level configuration. Set [environment] once during startup.
class AppConfig {
  AppConfig._();

  static Environment environment = Environment.development;

  static String get baseUrl {
    switch (environment) {
      case Environment.development:
        return 'https://dev-api.ridematch.example.com';
      case Environment.staging:
        return 'https://staging-api.ridematch.example.com';
      case Environment.production:
        return 'https://api.ridematch.example.com';
    }
  }

  static bool get isDevelopment => environment == Environment.development;

  static bool get enableLogging => environment != Environment.production;
}
