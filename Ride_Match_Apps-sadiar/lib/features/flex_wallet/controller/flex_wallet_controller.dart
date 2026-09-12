// import 'package:get/get.dart';

// class ActivityItem {
//   final String title;
//   final String date;
//   final String amount;
//   final bool isPositive;

//   ActivityItem({
//     required this.title,
//     required this.date,
//     required this.amount,
//     required this.isPositive,
//   });
// }

// enum WalletStep { main, payment, success }

// class FlexWalletController extends GetxController {
//   // Coupon Wallet Overview
//   final totalCoupons = 1250.obs;
//   final activeCoupons = 42.obs;
//   final expiringCoupons = 5.obs;
//   final expiringHours = 40.obs;

//    final currentStep = WalletStep.main.obs;
//   final selectedTxAmount = 2.0.obs;
//   final lastTxId = 'RM-992384'.obs;

//   // Travel Wallet
//   final travelCoupons = 850.obs;
//   final categories = <String>['Coffee', 'Fuel', 'Parking', 'Food', 'Hotel'].obs;
//   final selectedCategory = 'Coffee'.obs;

//   // Earned Wallet
//   final earnedPercentage = 70.obs;
//   final earnedCredits = 400.obs;

//   // Gas Vouchers
//   final gasAvailable = 12.obs;
//   final gasOffered = 4.obs;
//   final gasUsed = 20.obs;
//   final voucherAmounts = <int>[2, 4, 6, 8, 10, 12, 14, 16, 18, 20].obs;
//   final selectedVoucherAmount = 6.obs;

//   // Active Missions
//   final missionTitle = '3-Ride Streak'.obs;
//   final missionSubtitle = 'Complete to earn a Premium Badge'.obs;
//   final completedRides = 2.obs;
//   final totalRides = 6.obs;

//   // Escrow
//   final escrowRideId = 'ACTIVE RIDE #R-882'.obs;
//   final escrowCoupons = 80.obs;
//   final isEscrowExpanded = false.obs;

//   // Recent Activity
//   final recentActivities = <ActivityItem>[
//     ActivityItem(title: 'Ride Reward', date: 'Yesterday, 6:45 PM', amount: '+25', isPositive: true),
//     ActivityItem(title: 'Gas Voucher Purchase', date: 'Oct 12, 6:15 AM', amount: '-\$6', isPositive: false),
//     ActivityItem(title: 'Starbucks Coupon Used', date: 'Oct 11, 4:15 AM', amount: '-1', isPositive: false),
//     ActivityItem(title: 'CO2 Bonus', date: 'Oct 10, 4:20 PM', amount: '+10', isPositive: true),
//   ].obs;

//   void selectCategory(String category) {
//     selectedCategory.value = category;
//   }

//   void selectVoucherAmount(int amount) {
//     selectedVoucherAmount.value = amount;
//   }

//   void toggleEscrow() {
//     isEscrowExpanded.value = !isEscrowExpanded.value;
//   }

//   void onSelectCoupons() {
//     Get.snackbar('Travel Coupons', 'Filtered by: ${selectedCategory.value}');
//   }

//   void onRedeemBenefits() {
//     Get.snackbar('Redeem', 'Redeem perks with ${earnedCredits.value} credits');
//   }

//    void goToPayment(double amount) {
//     selectedTxAmount.value = amount;
//     currentStep.value = WalletStep.payment;
//   }

//   void goToSuccess(String txId) {
//     lastTxId.value = txId;
//     currentStep.value = WalletStep.success;
//   }

//   void backToWallet() {
//     currentStep.value = WalletStep.main;
//   }


//   void onBuyGasVoucher() {
//     gasAvailable.value += selectedVoucherAmount.value;
//     recentActivities.insert(
//       0,
//       ActivityItem(
//         title: 'Gas Voucher Purchase',
//         date: 'Just now',
//         amount: '-\$${selectedVoucherAmount.value}',
//         isPositive: false,
//       ),
//     );
//     Get.snackbar('Voucher Purchased', 'Added \$${selectedVoucherAmount.value} Gas Voucher');
//   }

//   void onOpenMarketplace() {
//     Get.snackbar('Marketplace', 'Opening Trade & Exchange');
//   }

//   void onEarnMoreCoupons() {
//     completedRides.value = (completedRides.value + 1).clamp(0, totalRides.value);
//     totalCoupons.value += 25;
//     Get.snackbar('Streak Bonus', '+25 Coupons Added!');
//   }
// }

import 'package:get/get.dart';

class ActivityItem {
  final String title;
  final String date;
  final String amount;
  final bool isPositive;

  ActivityItem({
    required this.title,
    required this.date,
    required this.amount,
    required this.isPositive,
  });
}

// 🔥 ৩টি স্টেপ
enum FlexWalletStep { main, payment, success, missions }

class FlexWalletController extends GetxController {
  // Coupon Wallet Overview
  final totalCoupons = 1250.obs;
  final activeCoupons = 42.obs;
  final expiringCoupons = 5.obs;
  final expiringHours = 40.obs;

  // 🔥 স্টেপ স্টেট ও ভেরিয়েবল
  final currentStep = FlexWalletStep.main.obs;
  final selectedTxAmount = 6.0.obs;
  final lastTxId = 'RM-992384'.obs;
  final isProcessingPayment = false.obs;
  final selectedPaymentMethod = 0.obs; // 0: Apple/Google Pay, 1: Card, 2: Balance

  // Travel Wallet
  final travelCoupons = 850.obs;
  final categories = <String>['Coffee', 'Fuel', 'Parking', 'Food', 'Hotel'].obs;
  final selectedCategory = 'Coffee'.obs;

  // Earned Wallet
  final earnedPercentage = 70.obs;
  final earnedCredits = 400.obs;

  // Gas Vouchers
  final gasAvailable = 12.obs;
  final gasOffered = 4.obs;
  final gasUsed = 20.obs;
  final voucherAmounts = <int>[2, 4, 6, 8, 10, 12, 14, 16, 18, 20].obs;
  final selectedVoucherAmount = 6.obs;

  // Active Missions
  final missionTitle = '3-Ride Streak'.obs;
  final missionSubtitle = 'Complete to earn a Premium Badge'.obs;
  final completedRides = 2.obs;
  final totalRides = 6.obs;
  // final isShowingMissions = false.obs;


  // Escrow
  final escrowRideId = 'ACTIVE RIDE #R-882'.obs;
  final escrowCoupons = 80.obs;
  final isEscrowExpanded = false.obs;

  // Recent Activity
  final recentActivities = <ActivityItem>[
    ActivityItem(title: 'Ride Reward', date: 'Yesterday, 6:45 PM', amount: '+25', isPositive: true),
    ActivityItem(title: 'Gas Voucher Purchase', date: 'Oct 12, 6:15 AM', amount: '-\$6', isPositive: false),
    ActivityItem(title: 'Starbucks Coupon Used', date: 'Oct 11, 4:15 AM', amount: '-1', isPositive: false),
    ActivityItem(title: 'CO2 Bonus', date: 'Oct 10, 4:20 PM', amount: '+10', isPositive: true),
  ].obs;

  void selectCategory(String category) {
    selectedCategory.value = category;
  }

  void selectVoucherAmount(int amount) {
    selectedVoucherAmount.value = amount;
  }

  void toggleEscrow() {
    isEscrowExpanded.value = !isEscrowExpanded.value;
  }

  void onSelectCoupons() {
    Get.snackbar('Travel Coupons', 'Filtered by: ${selectedCategory.value}');
  }

  void onRedeemBenefits() {
    Get.snackbar('Redeem', 'Redeem perks with ${earnedCredits.value} credits');
  }

  // 🔥 ১. Buy বাটনে চাপ দিলে পেমেন্ট স্টেপে যাওয়ার মেথড
  void goToPayment([double? amount]) {
    selectedTxAmount.value = amount ?? selectedVoucherAmount.value.toDouble();
    currentStep.value = FlexWalletStep.payment;
  }

  void selectPaymentMethod(int index) {
    selectedPaymentMethod.value = index;
  }

  // 🔥 ২. পেমেন্ট পেজে "Pay Now" চাপলে প্রসেসিং করে সাকসেসে যাওয়ার মেথড
  Future<void> confirmPayment() async {
    isProcessingPayment.value = true;
    await Future.delayed(const Duration(milliseconds: 800));
    isProcessingPayment.value = false;

    // ব্যালেন্স ও ট্রানজাকশন হিস্ট্রি আপডেট
    gasAvailable.value += selectedTxAmount.value.toInt();
    
    // ইউনিক ট্রানজাকশন আইডি তৈরি
    final randomDigits = 100000 + (DateTime.now().millisecondsSinceEpoch % 899999);
    lastTxId.value = 'RM-$randomDigits';

    recentActivities.insert(
      0,
      ActivityItem(
        title: 'Gas Voucher Purchase',
        date: 'Just now',
        amount: '-\$${selectedTxAmount.value.toInt()}',
        isPositive: false,
      ),
    );

    // সাকসেস স্ক্রিনে পাঠানো
    currentStep.value = FlexWalletStep.success;
  }

  // 🔥 ৩. সাকসেস পেজের "View Wallet" বা ব্যাক চাপলে মেইন ওয়ালেটে ফিরে আসার মেথড
  void backToWallet() {
    currentStep.value = FlexWalletStep.main;
  }

  void onBuyGasVoucher() {
    goToPayment();
  }

  void onOpenMarketplace() {
    Get.snackbar('Marketplace', 'Opening Trade & Exchange');
  }

  void onEarnMoreCoupons() {
    // completedRides.value = (completedRides.value + 1).clamp(0, totalRides.value);
    // totalCoupons.value += 25;
    // Get.snackbar('Streak Bonus', '+25 Coupons Added!');
    // Get.toNamed('/missions');
     currentStep.value = FlexWalletStep.missions;
  }
}