import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../controllers/chat_details_controller.dart';
import '../models/chat_models.dart';
import '../widgets/chat_details_top_bar.dart';
import '../widgets/chat_input_bar.dart';
import '../widgets/chat_message_bubble.dart';

class ChatDetailsView extends GetView<ChatDetailsController> {
  const ChatDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = controller.isDark;
    final scaffold = isDark ? const Color(0xFF0D0F11) : Colors.white;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: (isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark)
          .copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor:
            isDark ? const Color(0xFF0B0D0F) : Colors.white,
        systemNavigationBarIconBrightness:
            isDark ? Brightness.light : Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: scaffold,
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              ChatDetailsTopBar(
                name: controller.thread.name,
                avatarUrl: controller.thread.avatarUrl,
                onBack: controller.goBack,
                isDark: isDark,
              ),
              Expanded(
                child: Obx(() {
                  final items = controller.messages;
                  return ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                    itemCount: items.length + 1,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return ChatDateSeparator(
                          label: 'Today',
                          isDark: isDark,
                        );
                      }
                      final message = items[index - 1];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 14),
                        child: ChatMessageBubble(
                          message: message,
                          isDark: isDark,
                          isPlayingVoice: message.type == ChatMessageType.voice &&
                              controller.isPlayingVoice.value,
                          onPlayVoice: message.type == ChatMessageType.voice
                              ? controller.toggleVoicePlay
                              : null,
                        ),
                      );
                    },
                  );
                }),
              ),
              ChatInputBar(
                controller: controller.messageController,
                onSend: controller.sendMessage,
                onEmojiTap: controller.onEmojiTap,
                onLocationTap: controller.onLocationTap,
                onMicTap: controller.onMicTap,
                isDark: isDark,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
