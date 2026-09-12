import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../main_nav/mode_theme.dart';
import '../models/chat_models.dart';

class ChatDetailsController extends GetxController {
  late final ChatThreadModel thread;
  late final TextEditingController messageController;

  final RxList<ChatMessageModel> messages = <ChatMessageModel>[].obs;
  final RxBool isPlayingVoice = false.obs;

  bool get isDark => ModeTheme.isDark;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args is Map) {
      final raw = args['thread'];
      if (raw is ChatThreadModel) {
        thread = raw;
      } else {
        thread = ChatThreadModel.demos.firstWhere(
          (t) => t.id == 'michael',
          orElse: () => ChatThreadModel.demos.first,
        );
      }
    } else if (args is ChatThreadModel) {
      thread = args;
    } else {
      thread = ChatThreadModel.demos.firstWhere(
        (t) => t.id == 'michael',
        orElse: () => ChatThreadModel.demos.first,
      );
    }

    messageController = TextEditingController();
    messages.assignAll(ChatMessageModel.demoFor(thread.id));
  }

  void goBack() => Get.back();

  void sendMessage() {
    final text = messageController.text.trim();
    if (text.isEmpty) return;

    messages.add(
      ChatMessageModel(
        id: 'local_${DateTime.now().millisecondsSinceEpoch}',
        isMine: true,
        text: text,
        timeLabel: _nowLabel(),
        isRead: false,
      ),
    );
    messageController.clear();
  }

  void toggleVoicePlay() {
    isPlayingVoice.value = !isPlayingVoice.value;
  }

  void onEmojiTap() {
    Get.snackbar(
      'Emoji',
      'Emoji picker coming soon.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF1F2937),
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
    );
  }

  void onLocationTap() {
    Get.snackbar(
      'Location',
      'Share location coming soon.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF1F2937),
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
    );
  }

  void onMicTap() {
    Get.snackbar(
      'Voice',
      'Voice recording coming soon.',
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

  @override
  void onClose() {
    messageController.dispose();
    super.onClose();
  }
}
