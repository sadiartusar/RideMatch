class RideVerificationModel {
  const RideVerificationModel({
    required this.riderName,
    required this.riderAvatar,
    required this.pinCode,
    required this.qrPayload,
    required this.sharedKm,
    required this.couponsTransferred,
    required this.gasVoucherAmount,
    required this.co2SavedKg,
    required this.fuelSavedPercent,
    required this.rewardPoints,
    this.isDark = true,
  });

  final String riderName;
  final String riderAvatar;
  final String pinCode;
  final String qrPayload;
  final double sharedKm;
  final int couponsTransferred;
  final double gasVoucherAmount;
  final double co2SavedKg;
  final int fuelSavedPercent;
  final int rewardPoints;
  final bool isDark;

  static const RideVerificationModel defaultRide = RideVerificationModel(
    riderName: 'Marcus Miller',
    riderAvatar: 'assets/images/profile_hero.png',
    pinCode: '4821',
    qrPayload: 'RIDEMATCH_VERIFY_4821_MARCUS_MILLER',
    sharedKm: 4.8,
    couponsTransferred: 1,
    gasVoucherAmount: 9.60,
    co2SavedKg: 2.4,
    fuelSavedPercent: 17,
    rewardPoints: 125,
    isDark: true,
  );
}
