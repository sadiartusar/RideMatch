enum OutgoingRequestStatus { waiting, sent, accepted, expired }

class ConnectionFriend {
  const ConnectionFriend({
    required this.id,
    required this.name,
    required this.avatarUrl,
    required this.mutualRides,
    required this.sharedCircles,
    this.isVerified = false,
  });

  final String id;
  final String name;
  final String avatarUrl;
  final int mutualRides;
  final int sharedCircles;
  final bool isVerified;

  String get statsLabel {
    final circleLabel =
        sharedCircles == 1 ? '1 shared circle' : '$sharedCircles shared circles';
    return '$mutualRides mutual rides • $circleLabel';
  }

  static const List<ConnectionFriend> demos = [
    ConnectionFriend(
      id: 'marcus',
      name: 'Marcus Chen',
      avatarUrl:
          'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=200&h=200&fit=crop',
      mutualRides: 14,
      sharedCircles: 3,
      isVerified: true,
    ),
    ConnectionFriend(
      id: 'sarah',
      name: 'Sarah Jenkins',
      avatarUrl:
          'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=200&h=200&fit=crop',
      mutualRides: 8,
      sharedCircles: 1,
    ),
    ConnectionFriend(
      id: 'david',
      name: 'David Okoro',
      avatarUrl:
          'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=200&h=200&fit=crop',
      mutualRides: 22,
      sharedCircles: 5,
      isVerified: true,
    ),
  ];
}

class IncomingConnectionRequest {
  const IncomingConnectionRequest({
    required this.id,
    required this.name,
    required this.age,
    required this.avatarUrl,
    required this.matchPercent,
    required this.routeLabel,
    required this.tags,
    required this.trustScore,
    this.isVerified = true,
  });

  final String id;
  final String name;
  final int age;
  final String avatarUrl;
  final int matchPercent;
  final String routeLabel;
  final List<String> tags;
  final int trustScore;
  final bool isVerified;

  String get nameAgeLabel => '$name, $age';

  static const List<IncomingConnectionRequest> demos = [
    IncomingConnectionRequest(
      id: 'alex',
      name: 'Alex Morgan',
      age: 28,
      avatarUrl:
          'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=200&h=200&fit=crop',
      matchPercent: 88,
      routeLabel: 'Startup Founders Route',
      tags: ['Tech', 'Fintech', 'Cycling'],
      trustScore: 94,
    ),
    IncomingConnectionRequest(
      id: 'jordan',
      name: 'Jordan Lee',
      age: 31,
      avatarUrl:
          'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=200&h=200&fit=crop',
      matchPercent: 76,
      routeLabel: 'Downtown Express',
      tags: ['Design', 'Coffee', 'Music'],
      trustScore: 87,
    ),
  ];
}

class OutgoingConnectionRequest {
  const OutgoingConnectionRequest({
    required this.id,
    required this.name,
    required this.avatarUrl,
    required this.contextLabel,
    required this.status,
    required this.timeLabel,
    this.isVerified = true,
  });

  final String id;
  final String name;
  final String avatarUrl;
  final String contextLabel;
  final OutgoingRequestStatus status;
  final String timeLabel;
  final bool isVerified;

  String get statusLabel => switch (status) {
        OutgoingRequestStatus.waiting => 'Waiting',
        OutgoingRequestStatus.sent => 'Sent',
        OutgoingRequestStatus.accepted => 'Accepted',
        OutgoingRequestStatus.expired => 'Expired',
      };

  static const List<OutgoingConnectionRequest> demos = [
    OutgoingConnectionRequest(
      id: 'sarah_out',
      name: 'Sarah Jenkins',
      avatarUrl:
          'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=200&h=200&fit=crop',
      contextLabel: 'Met on San Francisco Route',
      status: OutgoingRequestStatus.waiting,
      timeLabel: '2h ago',
    ),
    OutgoingConnectionRequest(
      id: 'david_out',
      name: 'David Chen',
      avatarUrl:
          'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=200&h=200&fit=crop',
      contextLabel: 'Met on Tech Hub Express',
      status: OutgoingRequestStatus.sent,
      timeLabel: '5h ago',
    ),
    OutgoingConnectionRequest(
      id: 'elena_out',
      name: 'Elena Rodriguez',
      avatarUrl:
          'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=200&h=200&fit=crop',
      contextLabel: 'Met on Downtown Loop',
      status: OutgoingRequestStatus.accepted,
      timeLabel: '1d ago',
    ),
    OutgoingConnectionRequest(
      id: 'marcus_out',
      name: 'Marcus Thorne',
      avatarUrl:
          'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=200&h=200&fit=crop',
      contextLabel: 'Met on Green Commute',
      status: OutgoingRequestStatus.expired,
      timeLabel: '3d ago',
    ),
  ];
}
