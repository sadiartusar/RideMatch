import 'package:get/get.dart';

import '../onboarding/models/user_mode.dart';
import '../onboarding/services/mode_service.dart';
import '../chat/controllers/chat_details_controller.dart';
import '../community_circle/controllers/community_circles_controller.dart';
import '../community_circle/controllers/community_details_controller.dart';
import '../connections/controllers/connection_requests_controller.dart';
import '../connections/controllers/connections_controller.dart';
import '../edit_profile/controllers/edit_profile_controller.dart';
import '../notifications/controllers/notifications_controller.dart';
import '../settings/controllers/settings_controller.dart';

/// Resolves light/dark from the active app mode (Driving = dark).
class ModeTheme {
  ModeTheme._();

  static bool get isDark {
    if (Get.isRegistered<ModeService>()) {
      return Get.find<ModeService>().currentMode == UserMode.driver;
    }
    return false;
  }

  /// Clears pushed-route controllers after a mode switch.
  ///
  /// Does NOT delete ProfileController / ChatListController /
  /// SetDestinationController — those belong to the home shell bindings
  /// and must stay available for Profile / Chat / Find tabs.
  static void resetScopedControllers() {
    _delete<ChatDetailsController>();
    _delete<EditProfileController>();
    _delete<SettingsController>();
    _delete<NotificationsController>();
    _delete<CommunityCirclesController>();
    _delete<CommunityDetailsController>();
    _delete<ConnectionsController>();
    _delete<ConnectionRequestsController>();
  }

  static void _delete<T>() {
    if (Get.isRegistered<T>()) {
      Get.delete<T>(force: true);
    }
  }
}
