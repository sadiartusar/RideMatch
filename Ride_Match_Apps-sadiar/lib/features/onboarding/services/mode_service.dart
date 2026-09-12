import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/routes/app_routes.dart';
import '../../../core/storage/secure_storage_service.dart';
import '../../../core/storage/storage_keys.dart';
import '../models/user_mode.dart';

/// Persists and resolves the active app mode (Flex / Rider / Driver).
class ModeService {
  ModeService({required SecureStorageService secureStorage})
      : _secureStorage = secureStorage;

  final SecureStorageService _secureStorage;

  final Rxn<UserMode> rxCurrentMode = Rxn<UserMode>();

  UserMode? get currentMode => rxCurrentMode.value;

  Future<bool> hasCompletedOnboarding() async {
    final val = await _secureStorage.read(StorageKeys.hasCompletedOnboarding);
    return val == 'true';
  }

  Future<void> setOnboardingCompleted() async {
    await _secureStorage.write(StorageKeys.hasCompletedOnboarding, 'true');
  }

  Future<UserMode?> loadMode() async {
    final raw = await _secureStorage.read(StorageKeys.userMode);
    final mode = UserMode.tryParse(raw);
    rxCurrentMode.value = mode;
    _applyThemeForMode(mode);
    return mode;
  }

  Future<void> setMode(UserMode mode) async {
    await _secureStorage.write(StorageKeys.userMode, mode.storageValue);
    rxCurrentMode.value = mode;
    _applyThemeForMode(mode);
  }

  Future<void> clearMode() async {
    await _secureStorage.delete(StorageKeys.userMode);
    rxCurrentMode.value = null;
    _applyThemeForMode(null);
  }

  void _applyThemeForMode(UserMode? mode) {
    if (mode == UserMode.driver) {
      Get.changeThemeMode(ThemeMode.dark);
    } else {
      Get.changeThemeMode(ThemeMode.light);
    }
  }

  /// Home route for a mode. Shared trip/map/chat stay outside mode folders.
  String homeRouteFor(UserMode mode) {
    return switch (mode) {
      UserMode.flex => AppRoutes.flexHome,
      UserMode.rider => AppRoutes.riderHome,
      UserMode.driver => AppRoutes.driverHome,
    };
  }

  Future<String> resolvePostAuthRoute() async {
    final mode = await loadMode();
    if (mode == null) return AppRoutes.chooseMode;
    return homeRouteFor(mode);
  }
}
