import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/driver_chat_controller.dart';
import '../models/rider_match_model.dart';
import 'driver_chat_bubble.dart';
import 'driver_chat_trip_card.dart';

/// Embedded Direct Chat body for the Driver Home Shell.
class DriverChatBody extends StatelessWidget {
  const DriverChatBody({
    super.key,
    required this.match,
    required this.onBack,
  });

  final RiderMatchModel match;
  final VoidCallback onBack;

  DriverChatController get _controller {
    if (Get.isRegistered<DriverChatController>()) {
      final ctrl = Get.find<DriverChatController>();
      ctrl.updateMatch(match);
      return ctrl;
    }
    final ctrl = Get.put(DriverChatController());
    ctrl.updateMatch(match);
    return ctrl;
  }

  @override
  Widget build(BuildContext context) {
    const greenAccent = Color(0xFF32E116);
    final controller = _controller;

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) return;
        onBack();
      },
      child: Column(
        children: [
          // Top App Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.arrow_back_rounded,
                    color: Colors.white,
                    size: 22,
                  ),
                  onPressed: onBack,
                ),
                const SizedBox(width: 4),
                const Text(
                  'Chat',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: controller.onSosTap,
                  child: Container(
                    margin: const EdgeInsets.only(right: 16),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF381A1A),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: const Color(0xFFEF4444).withValues(alpha: 0.6),
                        width: 1,
                      ),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'SOS',
                          style: TextStyle(
                            color: Color(0xFFEF4444),
                            fontSize: 10.5,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        SizedBox(width: 4),
                        Text(
                          'EMERGENCY',
                          style: TextStyle(
                            color: Color(0xFFEF4444),
                            fontSize: 9.5,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Top Rider Info & Trip Card
          DriverChatTripCard(match: match),
          // Chat Messages Stream
          Expanded(
            child: Obx(() {
              final list = controller.messages;
              return ListView.builder(
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
                itemCount: list.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Center(
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF191C20),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          'Today',
                          style: TextStyle(
                            color: Color(0xFF9CA3AF),
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    );
                  }
                  final msg = list[index - 1];
                  return Obx(() {
                    return DriverChatBubble(
                      message: msg,
                      isPlayingVoice: controller.isPlayingVoice.value,
                      onPlayVoice: controller.toggleVoicePlay,
                    );
                  });
                },
              );
            }),
          ),
          // Quick replies row
          Container(
            height: 38,
            margin: const EdgeInsets.only(bottom: 8),
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: controller.quickReplies.length,
              separatorBuilder: (context, index) => const SizedBox(width: 8),
              itemBuilder: (context, i) {
                final reply = controller.quickReplies[i];
                return InkWell(
                  onTap: () => controller.selectQuickReply(reply),
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF191C20),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: const Color(0xFF2B313A),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      reply,
                      style: const TextStyle(
                        color: Color(0xFFE5E7EB),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          // Chat Input Bar
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFF16191D),
                      borderRadius: BorderRadius.circular(26),
                      border: Border.all(
                        color: const Color(0xFF2B313A),
                      ),
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: controller.onEmojiTap,
                          icon: const Icon(
                            Icons.sentiment_satisfied_alt_outlined,
                            color: Color(0xFF9CA3AF),
                            size: 22,
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            controller: controller.messageController,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                            textInputAction: TextInputAction.send,
                            onSubmitted: (_) => controller.sendMessage(),
                            decoration: const InputDecoration(
                              hintText: 'Type message...',
                              hintStyle: TextStyle(
                                color: Color(0xFF6B7280),
                                fontSize: 14,
                              ),
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: 10),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: controller.onLocationTap,
                          icon: const Icon(
                            Icons.location_on_outlined,
                            color: Color(0xFF9CA3AF),
                            size: 20,
                          ),
                        ),
                        IconButton(
                          onPressed: controller.onMicTap,
                          icon: const Icon(
                            Icons.mic_none_rounded,
                            color: Color(0xFF9CA3AF),
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                InkWell(
                  onTap: controller.sendMessage,
                  borderRadius: BorderRadius.circular(25),
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                      color: greenAccent,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.near_me_rounded,
                      color: Colors.black,
                      size: 22,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
