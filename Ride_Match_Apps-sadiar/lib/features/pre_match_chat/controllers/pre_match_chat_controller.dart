import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../match_list/models/driver_match_model.dart';
import '../models/pre_match_chat_model.dart';

class PreMatchChatController extends GetxController {
  late final PreMatchChatModel profile;
  final TextEditingController messageController = TextEditingController();

  final RxList<PreMatchMessage> messages = <PreMatchMessage>[].obs;
  final RxBool hasSentMessage = false.obs;

  static const List<String> quickReplies = [
    'On my way',
    '2 minutes',
    "I'm outside",
    "I'm ready",
  ];

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    DriverMatchModel? match;
    int? voucherDollars;

    if (args is Map) {
      final rawMatch = args['match'];
      if (rawMatch is DriverMatchModel) match = rawMatch;
      voucherDollars = args['voucherDollars'] as int?;
    } else if (args is DriverMatchModel) {
      match = args;
    }

    profile = match == null
        ? PreMatchChatModel.demo
        : PreMatchChatModel.fromMatch(
            match,
            voucherDollars: voucherDollars,
          );

    messages.add(profile.initialMessage);
    hasSentMessage.value = false;
  }

  @override
  void onClose() {
    messageController.dispose();
    super.onClose();
  }

  void goBack() => Get.back();

  void selectQuickReply(String reply) {
    messageController.text = reply;
    messageController.selection = TextSelection.collapsed(
      offset: reply.length,
    );
  }

  void sendMessage() {
    final text = messageController.text.trim();
    if (text.isEmpty) return;

    if (hasSentMessage.value) {
      Get.snackbar(
        'One-time message',
        'You can send only 1 message before they accept.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFF1F2937),
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
      );
      return;
    }

    messages
      ..clear()
      ..add(
        PreMatchMessage(
          text: text,
          timeLabel: _nowLabel(),
        ),
      );
    hasSentMessage.value = true;
    messageController.clear();
  }

  void openSafety() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(
                    Icons.shield_outlined,
                    color: Color(0xFF16A34A),
                    size: 24,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Safety Protocols Active',
                    style: TextStyle(
                      color: Color(0xFF111827),
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
                  color: Color(0xFF4B5563),
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
                    backgroundColor: AppColors.button,
                    foregroundColor: const Color(0xFF111827),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
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

  void onEmojiTap() => _comingSoon('Emoji picker');

  void onLocationTap() => _comingSoon('Share location');

  void onMicTap() => _comingSoon('Voice message');

  void _comingSoon(String label) {
    Get.snackbar(
      label,
      '$label is coming soon.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF1F2937),
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
    );
  }

  String _nowLabel() {
    final now = DateTime.now();
    final hour = now.hour % 12 == 0 ? 12 : now.hour % 12;
    final minute = now.minute.toString().padLeft(2, '0');
    final period = now.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $period';
  }
}
