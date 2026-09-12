import 'package:flutter/material.dart';

class RiderQuoteCard extends StatelessWidget {
  const RiderQuoteCard({
    super.key,
    this.quote = '"Your next best move is based on route, wallet, and trust."',
  });

  final String quote;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFEAF8EC),
        borderRadius: BorderRadius.circular(12),
      ),
      clipBehavior: Clip.antiAlias,
      child: IntrinsicHeight(
        child: Row(
          children: [
            // Green vertical accent bar
            Container(
              width: 5,
              color: const Color(0xFF16A34A),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Text(
                  quote,
                  style: const TextStyle(
                    color: Color(0xFF166534),
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.italic,
                    height: 1.4,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
