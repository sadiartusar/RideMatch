import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/routes/app_routes.dart';
import '../../drawer/controllers/app_drawer_controller.dart';
import '../../drawer/models/drawer_nav_item.dart';
import '../../main_nav/mode_theme.dart';
import '../models/connection_models.dart';

enum ConnectionRequestTab { incoming, outgoing }

class ConnectionRequestsController extends GetxController {
  final Rx<ConnectionRequestTab> selectedTab =
      ConnectionRequestTab.incoming.obs;
  final RxList<IncomingConnectionRequest> incoming =
      RxList<IncomingConnectionRequest>(IncomingConnectionRequest.demos);
  final RxList<OutgoingConnectionRequest> outgoing =
      RxList<OutgoingConnectionRequest>(OutgoingConnectionRequest.demos);
  final Rxn<OutgoingRequestStatus> outgoingFilter = Rxn<OutgoingRequestStatus>();

  bool get isDark => ModeTheme.isDark;

  int get incomingCount => incoming.length;

  List<({String label, OutgoingRequestStatus? status})> get outgoingFilterChips =>
      [
        (label: '${outgoing.length} Sent', status: null),
        (
          label:
              '${outgoing.where((e) => e.status == OutgoingRequestStatus.waiting).length} Pending',
          status: OutgoingRequestStatus.waiting,
        ),
        (
          label:
              '${outgoing.where((e) => e.status == OutgoingRequestStatus.accepted).length} Accepted',
          status: OutgoingRequestStatus.accepted,
        ),
        (
          label:
              '${outgoing.where((e) => e.status == OutgoingRequestStatus.expired).length} Expired',
          status: OutgoingRequestStatus.expired,
        ),
      ];

  List<OutgoingConnectionRequest> get filteredOutgoing {
    final filter = outgoingFilter.value;
    if (filter == null) return outgoing.toList();
    return outgoing.where((e) => e.status == filter).toList();
  }

  void goBack() => Get.back();

  void openNotifications() {
    Get.toNamed(
      AppRoutes.notifications,
      arguments: {'isDark': isDark},
    );
  }

  void openMenu() {
    AppDrawerController.open(
      userName: 'Member',
      selectedId: DrawerNavId.connections,
      isDark: isDark,
      onOpenNotifications: openNotifications,
      onChangeMode: () => Get.toNamed(AppRoutes.chooseMode),
    );
  }

  void selectTab(ConnectionRequestTab tab) {
    selectedTab.value = tab;
  }

  void setOutgoingFilter(OutgoingRequestStatus? status) {
    if (status == null) {
      outgoingFilter.value = null;
      return;
    }
    outgoingFilter.value =
        outgoingFilter.value == status ? null : status;
  }

  void acceptIncoming(IncomingConnectionRequest request) {
    incoming.removeWhere((e) => e.id == request.id);
    Get.snackbar(
      'Accepted',
      'You accepted ${request.name}.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF1F2937),
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
    );
  }

  void ignoreIncoming(IncomingConnectionRequest request) {
    incoming.removeWhere((e) => e.id == request.id);
    Get.snackbar(
      'Ignored',
      'You ignored ${request.name}.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF1F2937),
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
    );
  }

  void cancelOutgoing(OutgoingConnectionRequest request) {
    outgoing.removeWhere((e) => e.id == request.id);
    Get.snackbar(
      'Cancelled',
      'Request to ${request.name} cancelled.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF1F2937),
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
    );
  }

  void messageOutgoing(OutgoingConnectionRequest request) {
    Get.toNamed(AppRoutes.chatDetails);
  }

  void resendOutgoing(OutgoingConnectionRequest request) {
    final index = outgoing.indexWhere((e) => e.id == request.id);
    if (index == -1) return;
    outgoing[index] = OutgoingConnectionRequest(
      id: request.id,
      name: request.name,
      avatarUrl: request.avatarUrl,
      contextLabel: request.contextLabel,
      status: OutgoingRequestStatus.sent,
      timeLabel: 'Just now',
      isVerified: request.isVerified,
    );
    Get.snackbar(
      'Resent',
      'Request resent to ${request.name}.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF1F2937),
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
    );
  }
}
