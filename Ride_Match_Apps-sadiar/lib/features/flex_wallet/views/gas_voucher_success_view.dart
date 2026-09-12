import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../main_nav/main_tab_nav.dart';

class GasVoucherSuccessView extends StatelessWidget {
  const GasVoucherSuccessView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // আর্গুমেন্ট থেকে ডেটা রিড করা
    final args = (Get.arguments is Map) ? Get.arguments as Map : {};
    final double amount = (args['amount'] != null) ? (args['amount'] as num).toDouble() : 2.0;
    final String transactionId = args['transactionId']?.toString() ?? 'RM-992384';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF111827)),
          onPressed: () {
            // ব্যাক বাটনে চাপলেও ওয়ালেট ট্যাবে নিয়ে যাবে
            MainTabNav.showWallet();
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            children: [
              const SizedBox(height: 24),
              // ১. সবুজ সার্কেলের ভেতর সাদা টিক
              Container(
                width: 80,
                height: 80,
                decoration: const BoxDecoration(
                  color: Color(0xFF00E63D),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check, color: Colors.white, size: 48),
              ),
              const SizedBox(height: 28),

              // ২. টাইটেল
              const Text(
                'Electric / Gas\nVoucher Ready!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF111827),
                  letterSpacing: -0.5,
                  height: 1.25,
                ),
              ),
              const SizedBox(height: 12),

              // ৩. সাবটাইটেল
              Text(
                'Your \$${amount.toStringAsFixed(2)} gas voucher has been\nadded to your Travel Wallet and is\nready to use.',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 13,
                  color: Color(0xFF6B7280),
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 36),

              // ৪. ভাউচার ডিটেইলস কার্ড
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFE5E7EB)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.02),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      '\$${amount.toStringAsFixed(2)} Electric & Gas Voucher',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF111827),
                      ),
                    ),
                    const SizedBox(height: 14),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'TRANSACTION ID:',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                            color: Color(0xFF9CA3AF),
                          ),
                        ),
                        Text(
                          transactionId,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF374151),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // ৫. Pro Tip বক্স
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFFF0FDF4),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFFBBF7D0)),
                ),
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.lightbulb_outline,
                      color: Color(0xFF15803D),
                      size: 20,
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Pro Tip: Drivers in your network prioritize ride requests with gas incentives during peak hours.',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF166534),
                          height: 1.4,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(),

              // ৬. "View Wallet" নিয়ন গ্রিন বাটন
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    // এটি সরাসরি Wallet ট্যাবে ফিরিয়ে নিয়ে যাবে
                    MainTabNav.showWallet();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00E63D),
                    foregroundColor: Colors.black,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    'View Wallet',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}