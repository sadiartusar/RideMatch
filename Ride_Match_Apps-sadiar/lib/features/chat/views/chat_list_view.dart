import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../controllers/chat_list_controller.dart';
import '../widgets/chat_list_body.dart';

/// Standalone chat inbox route (no bottom nav — home shell owns navigation).
class ChatListView extends GetView<ChatListController> {
  const ChatListView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = controller.isDark;

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
        backgroundColor: isDark ? const Color(0xFF0D0F11) : Colors.white,
        body: const SafeArea(
          bottom: false,
          child: ChatListBody(),
        ),
      ),
    );
  }
}
