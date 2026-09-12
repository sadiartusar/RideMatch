import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../models/connection_models.dart';

class IncomingRequestCard extends StatelessWidget {
  const IncomingRequestCard({
    super.key,
    required this.request,
    required this.onAccept,
    required this.onIgnore,
    this.isDark = false,
  });

  final IncomingConnectionRequest request;
  final VoidCallback onAccept;
  final VoidCallback onIgnore;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final cardBg = isDark ? const Color(0xFF16181B) : Colors.white;
    final border =
        isDark ? const Color(0xFF2C333A) : const Color(0xFFE5E7EB);
    final titleColor = isDark ? Colors.white : const Color(0xFF111827);
    final muted = isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280);
    final green = isDark ? AppColors.button : const Color(0xFF15803D);

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: border),
        boxShadow: isDark
            ? null
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      request.avatarUrl,
                      width: 64,
                      height: 64,
                      fit: BoxFit.cover,
                      gaplessPlayback: true,
                      errorBuilder: (_, _, _) => Container(
                        width: 64,
                        height: 64,
                        color: const Color(0xFFE5E7EB),
                        child: const Icon(Icons.person),
                      ),
                    ),
                  ),
                  if (request.isVerified)
                    Positioned(
                      right: -2,
                      bottom: -2,
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: AppColors.button,
                          shape: BoxShape.circle,
                          border: Border.all(color: cardBg, width: 2),
                        ),
                        child: const Icon(
                          Icons.check_rounded,
                          size: 12,
                          color: Colors.black,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            request.nameAgeLabel,
                            style: TextStyle(
                              color: titleColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        Text(
                          '${request.matchPercent}% MATCH',
                          style: TextStyle(
                            color: green,
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Icon(Icons.alt_route_rounded, size: 15, color: green),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            request.routeLabel,
                            style: TextStyle(
                              color: green,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      request.tags.join('  '),
                      style: TextStyle(
                        color: muted,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: isDark
                  ? const Color(0xFF2A2418)
                  : const Color(0xFFFEF9C3),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.verified_user_outlined,
                  size: 16,
                  color: Color(0xFFCA8A04),
                ),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text(
                    'Social Trust Score',
                    style: TextStyle(
                      color: Color(0xFFCA8A04),
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Text(
                  '${request.trustScore}%',
                  style: const TextStyle(
                    color: Color(0xFFCA8A04),
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 46,
                  child: ElevatedButton(
                    onPressed: onAccept,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.button,
                      foregroundColor: AppColors.buttonForeground,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Accept',
                      style: TextStyle(fontWeight: FontWeight.w800),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: SizedBox(
                  height: 46,
                  child: OutlinedButton(
                    onPressed: onIgnore,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: muted,
                      side: BorderSide(color: border),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Ignore',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class OutgoingRequestCard extends StatelessWidget {
  const OutgoingRequestCard({
    super.key,
    required this.request,
    required this.onCancel,
    required this.onMessage,
    required this.onResend,
    this.isDark = false,
  });

  final OutgoingConnectionRequest request;
  final VoidCallback onCancel;
  final VoidCallback onMessage;
  final VoidCallback onResend;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final expired = request.status == OutgoingRequestStatus.expired;
    final cardBg = isDark ? const Color(0xFF16181B) : Colors.white;
    final border =
        isDark ? const Color(0xFF2C333A) : const Color(0xFFE5E7EB);
    final titleColor = isDark ? Colors.white : const Color(0xFF111827);
    final muted = isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280);
    final opacity = expired ? 0.55 : 1.0;

    return Opacity(
      opacity: opacity,
      child: Container(
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: border),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 14, 14, 12),
              child: Row(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      ClipOval(
                        child: Image.network(
                          request.avatarUrl,
                          width: 48,
                          height: 48,
                          fit: BoxFit.cover,
                          gaplessPlayback: true,
                          errorBuilder: (_, _, _) => Container(
                            width: 48,
                            height: 48,
                            color: const Color(0xFFE5E7EB),
                            child: const Icon(Icons.person),
                          ),
                        ),
                      ),
                      if (request.isVerified)
                        Positioned(
                          right: -1,
                          bottom: -1,
                          child: Container(
                            width: 16,
                            height: 16,
                            decoration: BoxDecoration(
                              color: AppColors.button,
                              shape: BoxShape.circle,
                              border: Border.all(color: cardBg, width: 1.5),
                            ),
                            child: const Icon(
                              Icons.check_rounded,
                              size: 10,
                              color: Colors.black,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          request.name,
                          style: TextStyle(
                            color: titleColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          request.contextLabel,
                          style: TextStyle(
                            color: muted,
                            fontSize: 12.5,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _StatusChip(status: request.status),
                      const SizedBox(height: 4),
                      Text(
                        request.timeLabel,
                        style: TextStyle(
                          color: muted,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(height: 1, color: border),
            InkWell(
              onTap: switch (request.status) {
                OutgoingRequestStatus.waiting ||
                OutgoingRequestStatus.sent =>
                  onCancel,
                OutgoingRequestStatus.accepted => onMessage,
                OutgoingRequestStatus.expired => onResend,
              },
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(18),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      switch (request.status) {
                        OutgoingRequestStatus.waiting ||
                        OutgoingRequestStatus.sent =>
                          Icons.cancel_outlined,
                        OutgoingRequestStatus.accepted =>
                          Icons.chat_bubble_outline_rounded,
                        OutgoingRequestStatus.expired => Icons.refresh_rounded,
                      },
                      size: 18,
                      color: switch (request.status) {
                        OutgoingRequestStatus.waiting ||
                        OutgoingRequestStatus.sent =>
                          const Color(0xFFDC2626),
                        OutgoingRequestStatus.accepted =>
                          const Color(0xFF16A34A),
                        OutgoingRequestStatus.expired => muted,
                      },
                    ),
                    const SizedBox(width: 8),
                    Text(
                      switch (request.status) {
                        OutgoingRequestStatus.waiting ||
                        OutgoingRequestStatus.sent =>
                          'Cancel Request',
                        OutgoingRequestStatus.accepted => 'Send Message',
                        OutgoingRequestStatus.expired => 'Resend Request',
                      },
                      style: TextStyle(
                        color: switch (request.status) {
                          OutgoingRequestStatus.waiting ||
                          OutgoingRequestStatus.sent =>
                            const Color(0xFFDC2626),
                          OutgoingRequestStatus.accepted =>
                            const Color(0xFF16A34A),
                          OutgoingRequestStatus.expired => muted,
                        },
                        fontSize: 13.5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.status});

  final OutgoingRequestStatus status;

  @override
  Widget build(BuildContext context) {
    final (bg, fg) = switch (status) {
      OutgoingRequestStatus.waiting => (
          const Color(0xFFFEF3C7),
          const Color(0xFFB45309),
        ),
      OutgoingRequestStatus.sent => (
          const Color(0xFFE0E7FF),
          const Color(0xFF4338CA),
        ),
      OutgoingRequestStatus.accepted => (
          const Color(0xFFDCFCE7),
          const Color(0xFF15803D),
        ),
      OutgoingRequestStatus.expired => (
          const Color(0xFFFEE2E2),
          const Color(0xFFB91C1C),
        ),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        switch (status) {
          OutgoingRequestStatus.waiting => 'Waiting',
          OutgoingRequestStatus.sent => 'Sent',
          OutgoingRequestStatus.accepted => 'Accepted',
          OutgoingRequestStatus.expired => 'Expired',
        },
        style: TextStyle(
          color: fg,
          fontSize: 11,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}
