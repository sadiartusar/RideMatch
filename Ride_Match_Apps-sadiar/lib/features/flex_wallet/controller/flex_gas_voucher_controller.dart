import 'package:get/get.dart';
import 'package:ride_match/core/routes/app_routes.dart';

import 'flex_wallet_controller.dart';

class GasVoucherCheckoutController extends GetxController {
  // সিলেক্টেড অ্যামাউন্ট (ডিফল্ট $2.00)
  final voucherAmount = 2.0.obs;
  final transactionId = ''.obs;
  final isLoading = false.obs;

  // পেমেন্ট মেথড সিলেকশন (0: Apple Pay / Google Pay, 1: Card, 2: Wallet)
  final selectedPaymentMethod = 0.obs;

  @override
  void onInit() {
    super.onInit();
    // আগের পেজ থেকে পাঠানো arguments থেকে অ্যামাউন্ট রিসিভ করা
    if (Get.arguments != null && Get.arguments is Map) {
      final amt = Get.arguments['amount'];
      if (amt != null) {
        voucherAmount.value = (amt as num).toDouble();
      }
    }
    // একটি ইউনিক ট্রানজাকশন আইডি তৈরি
    final randomDigits = (100000 + (DateTime.now().millisecondsSinceEpoch % 899999));
    transactionId.value = 'RM-$randomDigits';
  }

  void selectPaymentMethod(int index) {
    selectedPaymentMethod.value = index;
  }

  // পেমেন্ট কনফার্মেশন ও সাকসেস পেজে যাওয়া
  Future<void> confirmPayment() async {
    isLoading.value = true;
    
    // সিমুলেটেড নেটওয়ার্ক কল (১ সেকেন্ড)
    await Future.delayed(const Duration(milliseconds: 900));
    isLoading.value = false;

    // FlexWalletController এর ব্যালেন্স ও হিস্ট্রিতে যোগ করা
    if (Get.isRegistered<FlexWalletController>()) {
      final walletCtrl = Get.find<FlexWalletController>();
      walletCtrl.gasAvailable.value += voucherAmount.value.toInt();
      walletCtrl.recentActivities.insert(
        0,
        ActivityItem(
          title: 'Gas Voucher Purchase',
          date: 'Just now',
          amount: '-\$${voucherAmount.value.toStringAsFixed(2)}',
          isPositive: false,
        ),
      );
    }

    // পেমেন্ট পেজ ক্লোজ করে সরাসরি Success পেজে নিয়ে যাওয়া
    Get.offNamed(
      AppRoutes.gasVoucherSuccess,
      arguments: {
        'amount': voucherAmount.value,
        'transactionId': transactionId.value,
      },
    );
  }
}