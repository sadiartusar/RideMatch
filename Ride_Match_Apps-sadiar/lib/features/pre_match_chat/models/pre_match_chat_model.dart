import '../../../core/constants/app_assets.dart';
import '../../match_list/models/driver_match_model.dart';

class PreMatchMessage {
  const PreMatchMessage({
    required this.text,
    required this.timeLabel,
    this.isMine = true,
    this.isDelivered = true,
  });

  final String text;
  final String timeLabel;
  final bool isMine;
  final bool isDelivered;
}

class PreMatchChatModel {
  const PreMatchChatModel({
    required this.id,
    required this.name,
    required this.avatarAsset,
    required this.rating,
    required this.vehicle,
    required this.isVerified,
    required this.isOnline,
    required this.pickup,
    required this.dropOff,
    required this.eta,
    required this.distance,
    required this.couponCount,
    required this.gasVoucher,
    required this.initialMessage,
  });

  final String id;
  final String name;
  final String avatarAsset;
  final double rating;
  final String vehicle;
  final bool isVerified;
  final bool isOnline;
  final String pickup;
  final String dropOff;
  final String eta;
  final String distance;
  final String couponCount;
  final String gasVoucher;
  final PreMatchMessage initialMessage;

  String get vehicleLabel => vehicle.toUpperCase();

  static const PreMatchChatModel demo = PreMatchChatModel(
    id: 'driver_alfred',
    name: 'Alfred E. Clark',
    avatarAsset: AppAssets.profileHero,
    rating: 4.9,
    vehicle: 'Tesla Model 3',
    isVerified: true,
    isOnline: true,
    pickup: 'San Francisco...',
    dropOff: 'Chinatown',
    eta: '5 min',
    distance: '1.8 km',
    couponCount: '1',
    gasVoucher: '\$9.60',
    initialMessage: PreMatchMessage(
      text:
          'Hey! 👋 Heading to Banani around 10:30 AM. I have coffee ☕ with me — want to share the ride?',
      timeLabel: '10:15 AM',
    ),
  );

  static PreMatchChatModel fromMatch(
    DriverMatchModel match, {
    int? voucherDollars,
  }) {
    final voucher = voucherDollars == null
        ? demo.gasVoucher
        : '\$${voucherDollars.toDouble().toStringAsFixed(2)}';
    return demo.copyWith(
      id: match.id,
      name: match.name,
      avatarAsset: match.avatarAsset,
      rating: match.rating,
      vehicle: match.vehicle,
      isVerified: match.isVerified,
      gasVoucher: voucher,
    );
  }

  PreMatchChatModel copyWith({
    String? id,
    String? name,
    String? avatarAsset,
    double? rating,
    String? vehicle,
    bool? isVerified,
    String? gasVoucher,
  }) {
    return PreMatchChatModel(
      id: id ?? this.id,
      name: name ?? this.name,
      avatarAsset: avatarAsset ?? this.avatarAsset,
      rating: rating ?? this.rating,
      vehicle: vehicle ?? this.vehicle,
      isVerified: isVerified ?? this.isVerified,
      isOnline: isOnline,
      pickup: pickup,
      dropOff: dropOff,
      eta: eta,
      distance: distance,
      couponCount: couponCount,
      gasVoucher: gasVoucher ?? this.gasVoucher,
      initialMessage: initialMessage,
    );
  }
}
