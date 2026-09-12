class WalletActivityItem {
  const WalletActivityItem({
    required this.id,
    required this.title,
    required this.dateTimeLabel,
    required this.amountLabel,
    required this.iconType, // 'ride', 'escrow', 'gas'
    this.isPositive = true,
    this.isCurrency = false,
  });

  final String id;
  final String title;
  final String dateTimeLabel;
  final String amountLabel;
  final String iconType;
  final bool isPositive;
  final bool isCurrency;
}

class WalletOfferItem {
  const WalletOfferItem({
    required this.id,
    required this.title,
    required this.couponCost,
    required this.iconType, // 'fuel', 'coffee'
  });

  final String id;
  final String title;
  final int couponCost;
  final String iconType;
}

class DriverWalletModel {
  const DriverWalletModel({
    required this.totalCoupons,
    required this.availableCoupons,
    required this.pendingCoupons,
    required this.gasIncentiveBalance,
    required this.offers,
    required this.activityLogs,
  });

  final int totalCoupons;
  final int availableCoupons;
  final int pendingCoupons;
  final double gasIncentiveBalance;
  final List<WalletOfferItem> offers;
  final List<WalletActivityItem> activityLogs;

  static const DriverWalletModel demo = DriverWalletModel(
    totalCoupons: 1250,
    availableCoupons: 850,
    pendingCoupons: 400,
    gasIncentiveBalance: 38.00,
    offers: [
      WalletOfferItem(
        id: 'off_1',
        title: 'Free Fuel',
        couponCost: 80,
        iconType: 'fuel',
      ),
      WalletOfferItem(
        id: 'off_2',
        title: 'Starbucks Coffee',
        couponCost: 20,
        iconType: 'coffee',
      ),
    ],
    activityLogs: [
      WalletActivityItem(
        id: 'act_1',
        title: 'Ride Completed',
        dateTimeLabel: '18.05.2024 - 14:02',
        amountLabel: '+45',
        iconType: 'ride',
      ),
      WalletActivityItem(
        id: 'act_2',
        title: 'Escrow Released',
        dateTimeLabel: '20.05.2024 - 09:45',
        amountLabel: '+120',
        iconType: 'escrow',
      ),
      WalletActivityItem(
        id: 'act_3',
        title: 'Gas Incentive Balance',
        dateTimeLabel: '21.05.2024 - 18:00',
        amountLabel: '\$9.60',
        iconType: 'gas',
        isCurrency: true,
      ),
    ],
  );
}
