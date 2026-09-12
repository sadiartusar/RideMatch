import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguageOption {
  const LanguageOption({
    required this.name,
    required this.flag,
  });

  final String name;
  final String flag;
}

const List<LanguageOption> kLanguageOptions = [
  LanguageOption(name: 'Arabic', flag: '🇸🇦'),
  LanguageOption(name: 'Bengali', flag: '🇧🇩'),
  LanguageOption(name: 'English', flag: '🇬🇧'),
  LanguageOption(name: 'French', flag: '🇫🇷'),
  LanguageOption(name: 'German', flag: '🇩🇪'),
  LanguageOption(name: 'Hindi', flag: '🇮🇳'),
  LanguageOption(name: 'Italian', flag: '🇮🇹'),
  LanguageOption(name: 'Japanese', flag: '🇯🇵'),
  LanguageOption(name: 'Javanese', flag: '🇮🇩'),
  LanguageOption(name: 'Korean', flag: '🇰🇷'),
  LanguageOption(name: 'Marathi', flag: '🇮🇳'),
  LanguageOption(name: 'Portuguese', flag: '🇵🇹'),
  LanguageOption(name: 'Russian', flag: '🇷🇺'),
  LanguageOption(name: 'Spanish', flag: '🇪🇸'),
  LanguageOption(name: 'Swahili', flag: '🇹🇿'),
  LanguageOption(name: 'Tamil', flag: '🇮🇳'),
  LanguageOption(name: 'Telugu', flag: '🇮🇳'),
  LanguageOption(name: 'Turkish', flag: '🇹🇷'),
  LanguageOption(name: 'Urdu', flag: '🇵🇰'),
];

/// Popup for selecting and adding a language.
class AddLanguagePopup extends StatefulWidget {
  const AddLanguagePopup({
    super.key,
    required this.isDark,
  });

  final bool isDark;

  static Future<String?> show({required bool isDark}) {
    return Get.dialog<String>(
      AddLanguagePopup(isDark: isDark),
      barrierColor: Colors.black.withValues(alpha: 0.45),
      barrierDismissible: true,
    );
  }

  @override
  State<AddLanguagePopup> createState() => _AddLanguagePopupState();
}

class _AddLanguagePopupState extends State<AddLanguagePopup> {
  String? _selected;
  bool _listOpen = false;

  void _toggleList() {
    setState(() => _listOpen = !_listOpen);
  }

  void _select(String name) {
    setState(() {
      _selected = name;
      _listOpen = false;
    });
  }

  void _done() {
    if (_selected == null || _selected!.isEmpty) {
      Get.snackbar('Required', 'Please select a language.');
      return;
    }
    Get.back(result: _selected);
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
    final screenHeight = MediaQuery.sizeOf(context).height;
    final maxHeight = screenHeight * (_listOpen ? 0.78 : 0.42);

    return Center(
      child: Material(
        color: Colors.transparent,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: MediaQuery.sizeOf(context).width - 48,
          height: _listOpen ? maxHeight : null,
          constraints: BoxConstraints(maxHeight: maxHeight),
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
            mainAxisSize: _listOpen ? MainAxisSize.max : MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add new Languages',
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
                      text: 'SELECT LANGUAGE ',
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
              InkWell(
                onTap: _toggleList,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 12, bottom: 12),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: lineColor),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          _selected ?? 'Select',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: _selected == null
                                ? (isDark
                                    ? const Color(0xFF6B7280)
                                    : const Color(0xFF9CA3AF))
                                : titleColor,
                          ),
                        ),
                      ),
                      Icon(
                        _listOpen
                            ? Icons.keyboard_arrow_down_rounded
                            : Icons.chevron_right_rounded,
                        size: 22,
                        color: const Color(0xFF9CA3AF),
                      ),
                    ],
                  ),
                ),
              ),
              if (_listOpen)
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.only(top: 4),
                    itemCount: kLanguageOptions.length,
                    itemBuilder: (context, index) {
                      final option = kLanguageOptions[index];
                      final selected = option.name == _selected;
                      return InkWell(
                        onTap: () => _select(option.name),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 11),
                          child: Row(
                            children: [
                              Text(
                                option.flag,
                                style: const TextStyle(fontSize: 20),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  option.name,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: selected
                                        ? FontWeight.w700
                                        : FontWeight.w500,
                                    color: titleColor,
                                  ),
                                ),
                              ),
                              if (selected)
                                const Icon(
                                  Icons.check_rounded,
                                  size: 18,
                                  color: Color(0xFF3DF416),
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )
              else ...[
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
            ],
          ),
        ),
      ),
    );
  }
}
