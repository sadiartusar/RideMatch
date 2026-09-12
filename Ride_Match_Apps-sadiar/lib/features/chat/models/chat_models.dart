enum ChatMessageType { text, voice }

class ChatThreadModel {
  const ChatThreadModel({
    required this.id,
    required this.name,
    required this.lastMessage,
    required this.timeLabel,
    required this.avatarUrl,
    this.isOnline = false,
    this.isVerified = false,
  });

  final String id;
  final String name;
  final String lastMessage;
  final String timeLabel;
  final String avatarUrl;
  final bool isOnline;
  final bool isVerified;

  static const List<ChatThreadModel> demos = [
    ChatThreadModel(
      id: 'sarah',
      name: 'Sarah Jenkins',
      lastMessage: "I'm standing near the SF Tech hub entrance.",
      timeLabel: '2M',
      avatarUrl:
          'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=200&h=200&fit=crop',
      isOnline: true,
    ),
    ChatThreadModel(
      id: 'michael',
      name: 'Michael Bankston',
      lastMessage: 'Heading towards Downtown, see you at 10:30.',
      timeLabel: '15M',
      avatarUrl:
          'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=200&h=200&fit=crop',
      isOnline: true,
    ),
    ChatThreadModel(
      id: 'elena',
      name: 'Elena Rossi',
      lastMessage: 'Can we stop at the coffee shop on the way?',
      timeLabel: '1H',
      avatarUrl:
          'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=200&h=200&fit=crop',
    ),
    ChatThreadModel(
      id: 'sasha',
      name: 'Sasha Blake',
      lastMessage: 'Thanks for the smooth ride! Highly recommended.',
      timeLabel: 'YESTERDAY',
      avatarUrl:
          'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=200&h=200&fit=crop',
      isVerified: true,
    ),
  ];
}

class ChatMessageModel {
  const ChatMessageModel({
    required this.id,
    required this.isMine,
    required this.timeLabel,
    this.text,
    this.type = ChatMessageType.text,
    this.voiceDuration,
    this.isRead = false,
  });

  final String id;
  final bool isMine;
  final String timeLabel;
  final String? text;
  final ChatMessageType type;
  final String? voiceDuration;
  final bool isRead;

  static List<ChatMessageModel> demoFor(String threadId) {
    if (threadId == 'michael') {
      return const [
        ChatMessageModel(
          id: 'm1',
          isMine: true,
          text: 'Hey! 👋 Heading to Banani now. Are you ready?',
          timeLabel: '10:15 AM',
          isRead: true,
        ),
        ChatMessageModel(
          id: 'm2',
          isMine: false,
          text: "I'll be there in 5 minutes.",
          timeLabel: '10:16 AM',
        ),
        ChatMessageModel(
          id: 'm3',
          isMine: true,
          text: "I'm waiting at the main gate.",
          timeLabel: '10:18 AM',
          isRead: true,
        ),
        ChatMessageModel(
          id: 'm4',
          isMine: false,
          type: ChatMessageType.voice,
          voiceDuration: '0:45',
          timeLabel: '10:42 AM',
        ),
      ];
    }

    return const [
      ChatMessageModel(
        id: 'd1',
        isMine: true,
        text: 'Hi! Are we still on for the ride?',
        timeLabel: '9:02 AM',
        isRead: true,
      ),
      ChatMessageModel(
        id: 'd2',
        isMine: false,
        text: 'Yes, see you at the pickup point.',
        timeLabel: '9:05 AM',
      ),
    ];
  }
}
