import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../chat/models/chat_models.dart';
import '../../main_nav/main_tab_nav.dart';
import '../models/rider_match_model.dart';
import 'driver_set_route_controller.dart';

class DriverChatController extends GetxController {
  RiderMatchModel match = RiderMatchModel.defaultMatches.first;
  late final TextEditingController messageController;

  final RxList<ChatMessageModel> messages = <ChatMessageModel>[].obs;
  final RxBool isPlayingVoice = false.obs;
  final RxInt selectedNavIndex = 1.obs;

  final List<String> quickReplies = [
    'On my way',
    '2 minutes',
    "I'm outside",
    "I'm at the gate",
    'Almost there!',
  ];

  void updateMatch(RiderMatchModel newMatch) {
    match = newMatch;
  }

  @override
  void onInit() {
    super.onInit();
    messageController = TextEditingController();

    final args = Get.arguments;
    if (args is Map && args['match'] is RiderMatchModel) {
      match = args['match'] as RiderMatchModel;
    }

    // Populate initial conversation matching wireframe
    messages.assignAll([
      const ChatMessageModel(
        id: 'msg_1',
        isMine: false,
        text:
            'Hey! 👋\nHeading to Banani around 10:30 AM. I have coffee ☕ with me — want to share the ride?',
        timeLabel: '10:15 AM',
        isRead: true,
      ),
      const ChatMessageModel(
        id: 'msg_2',
        isMine: true,
        text: "I'll be there in 5 minutes.",
        timeLabel: '10:32 AM',
        isRead: true,
      ),
      const ChatMessageModel(
        id: 'msg_3',
        isMine: false,
        text: "I'm waiting at the main gate.",
        timeLabel: '10:43 AM',
        isRead: true,
      ),
      const ChatMessageModel(
        id: 'msg_4',
        isMine: false,
        type: ChatMessageType.voice,
        voiceDuration: '0:45',
        timeLabel: '10:44 AM',
        isRead: true,
      ),
    ]);
  }

  void goBack() {
    if (Get.isRegistered<DriverSetRouteController>()) {
      Get.find<DriverSetRouteController>().backToMatchConfirm();
    } else {
      Get.back();
    }
  }

  void toggleVoicePlay() {
    isPlayingVoice.value = !isPlayingVoice.value;
  }

  void selectQuickReply(String reply) {
    messageController.text = reply;
    sendMessage();
  }

  void sendMessage() {
    final text = messageController.text.trim();
    if (text.isEmpty) return;

    messages.add(
      ChatMessageModel(
        id: 'msg_${DateTime.now().millisecondsSinceEpoch}',
        isMine: true,
        text: text,
        timeLabel: _currentTimeString(),
        isRead: false,
      ),
    );
    messageController.clear();
  }

  void onSosTap() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Color(0xFF221111),
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.warning_amber_rounded,
                color: Color(0xFFEF4444),
                size: 48,
              ),
              const SizedBox(height: 12),
              const Text(
                'Emergency SOS Active',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Instant alert with live GPS telemetry is shared with emergency dispatch.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Color(0xFFD1D5DB), fontSize: 13),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () => Get.back(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFEF4444),
                    foregroundColor: Colors.white,
                  ),
                  child: const Text(
                    'Cancel Alert',
                    style: TextStyle(fontWeight: FontWeight.w800),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onEmojiTap() {
    messageController.text += ' 👍';
  }

  void onLocationTap() {
    messages.add(
      ChatMessageModel(
        id: 'loc_${DateTime.now().millisecondsSinceEpoch}',
        isMine: true,
        text: '📍 Shared current location: Near Entrance Gate',
        timeLabel: _currentTimeString(),
        isRead: false,
      ),
    );
  }

  void onMicTap() {
    Get.snackbar(
      'Voice Note',
      'Hold to record voice message.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF1F2937),
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
    );
  }

  String _currentTimeString() {
    final now = DateTime.now();
    final hour = now.hour % 12 == 0 ? 12 : now.hour % 12;
    final minute = now.minute.toString().padLeft(2, '0');
    final period = now.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $period';
  }

  void onNavTap(int index) {
    if (index == 0) {
      MainTabNav.showHome();
      return;
    }
    if (index == 1) {
      MainTabNav.showRoute();
      return;
    }
    if (index == MainTabNav.chatIndex) {
      // already in chat
      return;
    }
    if (index == 3) {
      MainTabNav.showWallet(isDark: true);
      return;
    }
    if (index == MainTabNav.profileIndex) {
      MainTabNav.showProfile(isDark: true);
      return;
    }
    selectedNavIndex.value = index;
  }

  @override
  void onClose() {
    messageController.dispose();
    super.onClose();
  }
}
