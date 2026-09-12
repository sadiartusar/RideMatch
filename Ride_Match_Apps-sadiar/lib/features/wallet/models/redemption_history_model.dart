class RedemptionHistoryModel {
  const RedemptionHistoryModel({
    required this.orderId,
    required this.title,
    required this.merchant,
    required this.dateTimeLabel,
    required this.valueLabel,
    required this.status, // 'COMPLETED', 'PENDING', 'EXPIRED'
    required this.category, // 'Fuel', 'Coffee', 'Parking', 'Wash'
    this.subtitle,
    this.hasDetails = false,
    this.iconType = 'fuel',
  });

  final String orderId;
  final String title;
  final String merchant;
  final String dateTimeLabel;
  final String valueLabel;
  final String status;
  final String category;
  final String? subtitle;
  final bool hasDetails;
  final String iconType;

  String get displaySubtitle => subtitle ?? 'Merchant: $merchant';

  static const List<RedemptionHistoryModel> demoHistory = [
    RedemptionHistoryModel(
      orderId: '#TXN-90210-RM',
      title: 'Shell Hydrogen Voucher',
      merchant: 'Shell Global',
      subtitle: 'Merchant: Shell Global',
      dateTimeLabel: 'Oct 24, 2023 • 22:45',
      valueLabel: '\$15.00',
      status: 'COMPLETED',
      category: 'Fuel',
      hasDetails: true,
      iconType: 'wind',
    ),
    RedemptionHistoryModel(
      orderId: '#TXN-88124-RM',
      title: 'Starbucks Coffee',
      merchant: 'Mission Reward',
      subtitle: 'Source: Mission Reward',
      dateTimeLabel: 'Oct 22, 2023 • 08:15',
      valueLabel: 'Free',
      status: 'PENDING',
      category: 'Coffee',
      iconType: 'coffee',
    ),
    RedemptionHistoryModel(
      orderId: '#TXN-75412-RM',
      title: 'Downtown Parking',
      merchant: 'Ride Reward',
      subtitle: 'Source: Ride Reward',
      dateTimeLabel: 'Oct 18, 2023 • 14:30',
      valueLabel: '30 Coupon',
      status: 'EXPIRED',
      category: 'Parking',
      iconType: 'parking',
    ),
    RedemptionHistoryModel(
      orderId: '#TXN-64201-RM',
      title: 'Car Wash Deluxe',
      merchant: 'AutoShine',
      subtitle: 'Merchant: AutoShine',
      dateTimeLabel: 'Oct 12, 2023 • 11:20',
      valueLabel: '\$10.00 Off',
      status: 'COMPLETED',
      category: 'Fuel',
      iconType: 'wash',
    ),
  ];
}
