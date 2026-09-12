import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../controllers/pre_match_chat_controller.dart';
import '../widgets/pre_match_chat_header.dart';
import '../widgets/pre_match_input_bar.dart';
import '../widgets/pre_match_notice_banner.dart';
import '../widgets/pre_match_person_card.dart';

class PreMatchChatView extends GetView<PreMatchChatController> {
  const PreMatchChatView({super.key});

  static const double _phoneMaxWidth = 430;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: const Color(0xFFF7F8FA),
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: const Color(0xFFF7F8FA),
        body: SafeArea(
          bottom: false,
          child: Align(
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: _phoneMaxWidth),
              child: Column(
                children: [
                  PreMatchChatHeader(
                    onBack: controller.goBack,
                    onSafety: controller.openSafety,
                  ),
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
                      children: [
                        PreMatchPersonCard(profile: controller.profile),
                        const SizedBox(height: 12),
                        const PreMatchNoticeBanner(),
                        const SizedBox(height: 18),
                        const Center(
                          child: Text(
                            'Today',
                            style: TextStyle(
                              color: Color(0xFF9CA3AF),
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Obx(
                          () => Column(
                            children: [
                              for (final message in controller.messages) ...[
                                PreMatchMessageBubble(message: message),
                                const SizedBox(height: 10),
                              ],
                            ],
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          'Your message will be delivered when they open your request.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF9CA3AF),
                            fontSize: 12,
                            height: 1.4,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  PreMatchQuickReplies(
                    replies: PreMatchChatController.quickReplies,
                    onSelect: controller.selectQuickReply,
                  ),
                  const SizedBox(height: 8),
                  PreMatchInputBar(
                    controller: controller.messageController,
                    onSend: controller.sendMessage,
                    onEmojiTap: controller.onEmojiTap,
                    onLocationTap: controller.onLocationTap,
                    onMicTap: controller.onMicTap,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
