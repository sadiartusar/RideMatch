/// App persona selected after auth. Identity stays the same when mode changes.
enum UserMode {
  flex,
  rider,
  driver;

  String get storageValue => name;

  static UserMode? tryParse(String? value) {
    if (value == null || value.isEmpty) return null;
    for (final mode in UserMode.values) {
      if (mode.storageValue == value) return mode;
    }
    return null;
  }

  String get label => switch (this) {
    UserMode.flex => 'Flex',
    UserMode.rider => 'Rider',
    UserMode.driver => 'Driver',
  };
}
