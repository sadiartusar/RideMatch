class CommunityCircleMember {
  const CommunityCircleMember({
    required this.id,
    required this.name,
    required this.avatarUrl,
  });

  final String id;
  final String name;
  final String avatarUrl;
}

class CommunityCircleModel {
  const CommunityCircleModel({
    required this.id,
    required this.name,
    required this.memberCount,
    required this.extraMembersLabel,
    required this.avatarUrls,
    required this.about,
    required this.activeTodayLabel,
    required this.members,
    this.isJoined = false,
  });

  final String id;
  final String name;
  final int memberCount;
  final String extraMembersLabel;
  final List<String> avatarUrls;
  final String about;
  final String activeTodayLabel;
  final List<CommunityCircleMember> members;
  final bool isJoined;

  String get membersLabel => '$memberCount Members';

  CommunityCircleModel copyWith({bool? isJoined}) {
    return CommunityCircleModel(
      id: id,
      name: name,
      memberCount: memberCount,
      extraMembersLabel: extraMembersLabel,
      avatarUrls: avatarUrls,
      about: about,
      activeTodayLabel: activeTodayLabel,
      members: members,
      isJoined: isJoined ?? this.isJoined,
    );
  }

  static const _avatars = [
    'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=120&h=120&fit=crop',
    'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=120&h=120&fit=crop',
    'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=120&h=120&fit=crop',
    'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=120&h=120&fit=crop',
  ];

  static const List<CommunityCircleModel> demos = [
    CommunityCircleModel(
      id: 'tech_hub',
      name: 'Tech Hub Express',
      memberCount: 4,
      extraMembersLabel: '12+',
      avatarUrls: _avatars,
      about:
          'The go-to circle for tech professionals commuting from the city to the valley. Efficient routes, great networking, and a shared passion for innovation.',
      activeTodayLabel: '1 Today',
      members: [
        CommunityCircleMember(
          id: 'david',
          name: 'David K.',
          avatarUrl:
              'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=120&h=120&fit=crop',
        ),
        CommunityCircleMember(
          id: 'sarah',
          name: 'Sarah M.',
          avatarUrl:
              'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=120&h=120&fit=crop',
        ),
        CommunityCircleMember(
          id: 'leo',
          name: 'Leo W.',
          avatarUrl:
              'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=120&h=120&fit=crop',
        ),
        CommunityCircleMember(
          id: 'elena',
          name: 'Elena R.',
          avatarUrl:
              'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=120&h=120&fit=crop',
        ),
      ],
    ),
    CommunityCircleModel(
      id: 'downtown',
      name: 'Downtown Loop',
      memberCount: 15,
      extraMembersLabel: '8+',
      avatarUrls: _avatars,
      about:
          'Daily downtown commuters sharing reliable routes, traffic tips, and flexible pickup windows across the business district.',
      activeTodayLabel: '3 Today',
      isJoined: true,
      members: [
        CommunityCircleMember(
          id: 'david',
          name: 'David K.',
          avatarUrl:
              'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=120&h=120&fit=crop',
        ),
        CommunityCircleMember(
          id: 'sarah',
          name: 'Sarah M.',
          avatarUrl:
              'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=120&h=120&fit=crop',
        ),
        CommunityCircleMember(
          id: 'leo',
          name: 'Leo W.',
          avatarUrl:
              'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=120&h=120&fit=crop',
        ),
        CommunityCircleMember(
          id: 'elena',
          name: 'Elena R.',
          avatarUrl:
              'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=120&h=120&fit=crop',
        ),
      ],
    ),
    CommunityCircleModel(
      id: 'green',
      name: 'Green Commute',
      memberCount: 9,
      extraMembersLabel: '5+',
      avatarUrls: _avatars,
      about:
          'Eco-minded riders reducing solo trips with shared EV and hybrid routes. Cleaner miles, better company.',
      activeTodayLabel: '2 Today',
      members: [
        CommunityCircleMember(
          id: 'david',
          name: 'David K.',
          avatarUrl:
              'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=120&h=120&fit=crop',
        ),
        CommunityCircleMember(
          id: 'sarah',
          name: 'Sarah M.',
          avatarUrl:
              'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=120&h=120&fit=crop',
        ),
        CommunityCircleMember(
          id: 'leo',
          name: 'Leo W.',
          avatarUrl:
              'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=120&h=120&fit=crop',
        ),
        CommunityCircleMember(
          id: 'elena',
          name: 'Elena R.',
          avatarUrl:
              'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=120&h=120&fit=crop',
        ),
      ],
    ),
  ];
}
