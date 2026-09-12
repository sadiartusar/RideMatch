import 'package:flutter/material.dart';

class SocialMissionBanner extends StatelessWidget {
  final VoidCallback onInvite;

  const SocialMissionBanner({Key? key, required this.onInvite}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF111827),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            child: Opacity(
              opacity: 0.15,
              child: const Icon(Icons.people_alt, size: 80, color: Color(0xFF00E63D)),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Invite a Friend',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: const Color(0xFF00E63D),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      '+50',
                      style: TextStyle(fontSize: 11, fontWeight: FontWeight.w900, color: Colors.black),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              const Text(
                'Share the experience and earn big.',
                style: TextStyle(fontSize: 12, color: Color(0xFF9CA3AF)),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: onInvite,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00E63D),
                  foregroundColor: Colors.black,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text(
                  'SEND INVITE',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, letterSpacing: 0.5),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}