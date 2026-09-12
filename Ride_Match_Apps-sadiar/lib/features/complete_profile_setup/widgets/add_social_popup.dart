import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Popup for adding a custom social profile link.
class AddSocialPopup extends StatefulWidget {
  const AddSocialPopup({
    super.key,
    required this.isDark,
  });

  final bool isDark;

  static Future<String?> show({required bool isDark}) {
    return Get.dialog<String>(
      AddSocialPopup(isDark: isDark),
      barrierColor: Colors.black.withValues(alpha: 0.45),
      barrierDismissible: true,
    );
  }

  @override
  State<AddSocialPopup> createState() => _AddSocialPopupState();
}

class _AddSocialPopupState extends State<AddSocialPopup> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _done() {
    final value = _controller.text.trim();
    if (value.isEmpty) {
      Get.snackbar('Required', 'Please enter a profile link.');
      return;
    }
    Get.back(result: value);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = widget.isDark;
    final cardBg = isDark ? const Color(0xFF14171A) : Colors.white;
    final titleColor = isDark ? Colors.white : const Color(0xFF111827);
    final labelColor =
        isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280);
    final lineColor =
        isDark ? const Color(0xFF374151) : const Color(0xFFD1D5DB);

    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: MediaQuery.sizeOf(context).width - 48,
          padding: const EdgeInsets.fromLTRB(22, 26, 22, 20),
          decoration: BoxDecoration(
            color: cardBg,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: const Color(0xFF3DF416), width: 1.6),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.12),
                blurRadius: 24,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add new Social',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.italic,
                  fontFamily: 'serif',
                  color: titleColor,
                ),
              ),
              const SizedBox(height: 22),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'PROFILE LINK ',
                      style: TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.8,
                        color: labelColor,
                      ),
                    ),
                    const TextSpan(
                      text: '*',
                      style: TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFFEF4444),
                      ),
                    ),
                  ],
                ),
              ),
              TextField(
                controller: _controller,
                autofocus: true,
                keyboardType: TextInputType.url,
                cursorColor: const Color(0xFF3DF416),
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: titleColor,
                ),
                decoration: InputDecoration(
                  isDense: true,
                  hintText: 'https://www.facebook.com/james',
                  hintStyle: TextStyle(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w400,
                    color: isDark
                        ? const Color(0xFF6B7280)
                        : const Color(0xFF9CA3AF),
                  ),
                  contentPadding: const EdgeInsets.only(top: 10, bottom: 10),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: lineColor),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: lineColor),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFF3DF416),
                      width: 1.5,
                    ),
                  ),
                ),
                onSubmitted: (_) => _done(),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: Material(
                  color: const Color(0xFF3DF416),
                  borderRadius: BorderRadius.circular(14),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(14),
                    onTap: _done,
                    child: const Center(
                      child: Text(
                        'DONE',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.8,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
