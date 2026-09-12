class NotificationItemModel {
  const NotificationItemModel({
    required this.id,
    required this.title,
    required this.body,
    required this.timeLabel,
    this.isUnread = false,
  });

  final String id;
  final String title;
  final String body;
  final String timeLabel;
  final bool isUnread;

  static const List<NotificationItemModel> samples = [
    NotificationItemModel(
      id: '1',
      title: 'New match found',
      body: '3 drivers matched your route for your scheduled trip tomorrow.',
      timeLabel: '2 min ago',
      isUnread: true,
    ),
    NotificationItemModel(
      id: '2',
      title: 'Driver accepted',
      body: 'Your ride request for Downtown was accepted by Michael.',
      timeLabel: '8 min ago',
    ),
    NotificationItemModel(
      id: '3',
      title: 'Ride arriving soon',
      body: 'Driver will arrive in 3 minutes. Please head to the pickup point.',
      timeLabel: '15 min ago',
    ),
    NotificationItemModel(
      id: '4',
      title: 'Reward added',
      body: '+12 coupons deposited from your recent referral.',
      timeLabel: '32 min ago',
      isUnread: true,
    ),
    NotificationItemModel(
      id: '5',
      title: 'Coupons expiring',
      body: '8 coupons will expire tomorrow. Use them for your next ride!',
      timeLabel: '1 hr ago',
    ),
    NotificationItemModel(
      id: '6',
      title: 'Connection request',
      body: 'Sarah Wilson wants to connect with you on RideMatch.',
      timeLabel: 'Today',
      isUnread: true,
    ),
    NotificationItemModel(
      id: '7',
      title: 'New mission',
      body: 'Complete 3 rides this week to unlock a bonus coupon pack.',
      timeLabel: 'Today',
    ),
    NotificationItemModel(
      id: '8',
      title: 'Mission completed',
      body: 'You finished "Morning Commute Streak". +20 coupons added.',
      timeLabel: 'Yesterday',
    ),
    NotificationItemModel(
      id: '9',
      title: 'Connection accepted',
      body: 'Alex Chen is now in your trusted connections.',
      timeLabel: 'Yesterday',
    ),
    NotificationItemModel(
      id: '10',
      title: 'Ride verified',
      body: 'Your trip to Midtown was verified. Trust score updated.',
      timeLabel: '2 days ago',
    ),
  ];
}
