import 'package:flutter/material.dart';

class QuizOptionTile extends StatelessWidget {
  final String letter;
  final String optionText;
  final bool isSelected;
  final VoidCallback onTap;

  const QuizOptionTile({
    Key? key,
    required this.letter,
    required this.optionText,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xFFF9FAFB),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? const Color(0xFF15803D) : const Color(0xFFE5E7EB),
            width: isSelected ? 1.8 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF15803D) : const Color(0xFFF3F4F6),
                borderRadius: BorderRadius.circular(10),
              ),
              alignment: Alignment.center,
              child: Text(
                letter,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: isSelected ? Colors.white : const Color(0xFF374151),
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                optionText,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  color: isSelected ? const Color(0xFF15803D) : const Color(0xFF4B5563),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}