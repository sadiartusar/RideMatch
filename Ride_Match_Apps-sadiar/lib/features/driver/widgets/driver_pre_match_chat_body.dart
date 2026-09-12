import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/driver_pre_match_chat_controller.dart';
import '../models/rider_match_model.dart';
import 'driver_pre_match_summary_card.dart';

/// Embedded Pre-Match Chat body for the Driver Home Shell.
class DriverPreMatchChatBody extends StatelessWidget {
  const DriverPreMatchChatBody({
    super.key,
    required this.match,
    required this.onBack,
  });

  final RiderMatchModel match;
  final VoidCallback onBack;

  DriverPreMatchChatController get _controller {
    if (Get.isRegistered<DriverPreMatchChatController>()) {
      final ctrl = Get.find<DriverPreMatchChatController>();
      ctrl.updateMatch(match);
      return ctrl;
    }
    final ctrl = Get.put(DriverPreMatchChatController());
    ctrl.updateMatch(match);
    return ctrl;
  }

  @override
  Widget build(BuildContext context) {
    final controller = _controller;

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) return;
        onBack();
      },
      child: Column(
        children: [
          // Top Header Bar
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
                const Expanded(
                  child: Text(
                    'Pre-Match Chat',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: InkWell(
                    onTap: controller.openSafety,
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF32E116),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.shield_outlined,
                            color: Colors.black,
                            size: 14,
                          ),
                          SizedBox(width: 4),
                          Text(
                            'Safety',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 11,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Scrollable Messages Area
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: Column(
                children: [
                  // Trip Summary Card
                  DriverPreMatchSummaryCard(match: match),
                  const SizedBox(height: 14),
                  // One-time message notice banner
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF132A18),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: const Color(0xFF1F5128),
                        width: 1,
                      ),
                    ),
                    child: const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.chat_bubble_outline_rounded,
                          color: Color(0xFF32E116),
                          size: 18,
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'One-time message',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                'The message was sent with a ride request. You can only send a reply message after the request has been accepted.',
                                style: TextStyle(
                                  color: Color(0xFF9CA3AF),
                                  fontSize: 11,
                                  height: 1.3,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  // "Today" Date separator chip
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E2125),
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
                  const SizedBox(height: 14),
                  // Chat Bubbles list
                  Obx(
                    () => Column(
                      children: controller.chatMessages.map((msg) {
                        final isMe = msg['isMe'] == true;
                        return Align(
                          alignment: isMe
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            padding: const EdgeInsets.all(12),
                            constraints: BoxConstraints(
                              maxWidth:
                                  MediaQuery.of(context).size.width * 0.78,
                            ),
                            decoration: BoxDecoration(
                              color: isMe
                                  ? const Color(0xFF16381D)
                                  : const Color(0xFF1A1D21),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: isMe
                                    ? const Color(0xFF1F5128)
                                    : const Color(0xFF262B32),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: isMe
                                  ? CrossAxisAlignment.end
                                  : CrossAxisAlignment.start,
                              children: [
                                Text(
                                  msg['text'] as String,
                                  style: TextStyle(
                                    color: isMe
                                        ? Colors.white
                                        : const Color(0xFFE5E7EB),
                                    fontSize: 13,
                                    height: 1.35,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      msg['time'] as String,
                                      style: const TextStyle(
                                        color: Color(0xFF6B7280),
                                        fontSize: 10,
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    const Icon(
                                      Icons.done,
                                      color: Color(0xFF32E116),
                                      size: 12,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Quick reply chips row
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
                    child: Text(
                      reply,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          // Message Input Bar
          Container(
            padding: const EdgeInsets.fromLTRB(16, 6, 16, 10),
            decoration: const BoxDecoration(
              color: Color(0xFF0D0F11),
              border: Border(
                top: BorderSide(
                  color: Color(0xFF1F242B),
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                // Input box with emoji, location, mic
                Expanded(
                  child: Container(
                    height: 46,
                    decoration: BoxDecoration(
                      color: const Color(0xFF16191D),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: const Color(0xFF262B32),
                      ),
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 10),
                        const Icon(
                          Icons.sentiment_satisfied_alt_outlined,
                          color: Color(0xFF9CA3AF),
                          size: 20,
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: TextField(
                            controller: controller.messageController,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                            decoration: const InputDecoration(
                              hintText: 'Type message...',
                              hintStyle: TextStyle(
                                color: Color(0xFF6B7280),
                                fontSize: 13,
                              ),
                              border: InputBorder.none,
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: 12),
                            ),
                            onSubmitted: (_) => controller.sendMessage(),
                          ),
                        ),
                        const Icon(
                          Icons.location_on_outlined,
                          color: Color(0xFF9CA3AF),
                          size: 18,
                        ),
                        const SizedBox(width: 8),
                        const Icon(
                          Icons.mic_none_rounded,
                          color: Color(0xFF9CA3AF),
                          size: 18,
                        ),
                        const SizedBox(width: 12),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                // Send button
                InkWell(
                  onTap: controller.sendMessage,
                  borderRadius: BorderRadius.circular(23),
                  child: Container(
                    width: 46,
                    height: 46,
                    decoration: const BoxDecoration(
                      color: Color(0xFF32E116),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.send_rounded,
                      color: Colors.black,
                      size: 20,
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
