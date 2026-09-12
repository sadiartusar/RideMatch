import 'package:get/get.dart';

import '../../main_nav/mode_theme.dart';
import '../models/notification_item_model.dart';

class NotificationsController extends GetxController {
  bool get isDark => ModeTheme.isDark;

  final RxList<NotificationItemModel> notifications =
      RxList<NotificationItemModel>(NotificationItemModel.samples);

  void goBack() => Get.back();

  void onNotificationTap(NotificationItemModel item) {
    final index = notifications.indexWhere((n) => n.id == item.id);
    if (index == -1) return;

    final current = notifications[index];
    if (current.isUnread) {
      notifications[index] = NotificationItemModel(
        id: current.id,
        title: current.title,
        body: current.body,
        timeLabel: current.timeLabel,
        isUnread: false,
      );
    }
  }
}
