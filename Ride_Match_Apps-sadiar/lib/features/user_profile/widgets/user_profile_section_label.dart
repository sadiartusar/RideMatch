import 'package:flutter/material.dart';

class UserProfileSectionLabel extends StatelessWidget {
  const UserProfileSectionLabel(this.label, {super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(
        color: Color(0xFF9CA3AF),
        fontSize: 11,
        fontWeight: FontWeight.w800,
        letterSpacing: 0.8,
      ),
    );
  }
}
