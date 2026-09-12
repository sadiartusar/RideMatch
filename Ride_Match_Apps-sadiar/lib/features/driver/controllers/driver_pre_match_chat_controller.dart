import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../main_nav/main_tab_nav.dart';
import '../models/rider_match_model.dart';

class DriverPreMatchChatController extends GetxController {
  RiderMatchModel match = RiderMatchModel.defaultMatches.first;
  final TextEditingController messageController = TextEditingController();

  final RxList<String> quickReplies = <String>[
    'On my way',
    '2 minutes',
    "I'm outside",
    "I'm ready",
  ].obs;

  final RxList<Map<String, dynamic>> chatMessages = <Map<String, dynamic>>[].obs;
  final RxInt selectedNavIndex = 1.obs;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args is Map && args['match'] is RiderMatchModel) {
      match = args['match'] as RiderMatchModel;
    }
    _initMessages();
  }

  void updateMatch(RiderMatchModel newMatch) {
    match = newMatch;
    _initMessages();
  }

  void _initMessages() {
    chatMessages.assignAll([
      {
        'text': match.preMatchMessage,
        'isMe': false,
        'time': '10:15 AM',
      }
    ]);
  }

  @override
  void onClose() {
    messageController.dispose();
    super.onClose();
  }

  void selectQuickReply(String reply) {
    messageController.text = reply;
  }

  void sendMessage() {
    final text = messageController.text.trim();
    if (text.isEmpty) return;

    chatMessages.add({
      'text': text,
      'isMe': true,
      'time': 'Just now',
    });
    messageController.clear();
  }

  void openSafety() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Color(0xFF16181B),
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(Icons.shield_outlined, color: Color(0xFF32E116), size: 24),
                  SizedBox(width: 10),
                  Text(
                    'Safety Protocols Active',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Text(
                '• Audio/Location is protected.\n• Identity verified for both parties.\n• Emergency assistance ready 24/7.',
                style: TextStyle(
                  color: Color(0xFFD1D5DB),
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () => Get.back(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF32E116),
                    foregroundColor: Colors.black,
                  ),
                  child: const Text(
                    'Got It',
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
      MainTabNav.showChat(isDark: true);
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
}
