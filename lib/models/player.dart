import '../constants/ranks.dart';

class Player {
  final String name;
  final List<String> hobbies;
  final Map<String, String> hobbyLevels;
  final int level;
  final int currentXP;
  final int totalXP;
  final Rank rank;
  final int streak;
  final int longestStreak;
  final int consecutiveFailedDays;
  final DateTime? lastActiveDate;
  final bool onboardingComplete;

  const Player({
    required this.name,
    required this.hobbies,
    required this.hobbyLevels,
    required this.level,
    required this.currentXP,
    required this.totalXP,
    required this.rank,
    required this.streak,
    required this.longestStreak,
    required this.consecutiveFailedDays,
    required this.lastActiveDate,
    required this.onboardingComplete,
  });

  factory Player.initial() => const Player(
        name: '',
        hobbies: [],
        hobbyLevels: {},
        level: 1,
        currentXP: 0,
        totalXP: 0,
        rank: Rank.E,
        streak: 0,
        longestStreak: 0,
        consecutiveFailedDays: 0,
        lastActiveDate: null,
        onboardingComplete: false,
      );

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      name: json['name'] as String? ?? '',
      hobbies: List<String>.from(json['hobbies'] as List? ?? []),
      hobbyLevels: Map<String, String>.from(json['hobbyLevels'] as Map? ?? {}),
      level: json['level'] as int? ?? 1,
      currentXP: json['currentXP'] as int? ?? 0,
      totalXP: json['totalXP'] as int? ?? 0,
      rank: Rank.values.byName(json['rank'] as String? ?? 'E'),
      streak: json['streak'] as int? ?? 0,
      longestStreak: json['longestStreak'] as int? ?? 0,
      consecutiveFailedDays: json['consecutiveFailedDays'] as int? ?? 0,
      lastActiveDate: json['lastActiveDate'] != null
          ? DateTime.tryParse(json['lastActiveDate'] as String)
          : null,
      onboardingComplete: json['onboardingComplete'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'hobbies': hobbies,
        'hobbyLevels': hobbyLevels,
        'level': level,
        'currentXP': currentXP,
        'totalXP': totalXP,
        'rank': rank.name,
        'streak': streak,
        'longestStreak': longestStreak,
        'consecutiveFailedDays': consecutiveFailedDays,
        'lastActiveDate': lastActiveDate?.toIso8601String(),
        'onboardingComplete': onboardingComplete,
      };

  Player copyWith({
    String? name,
    List<String>? hobbies,
    Map<String, String>? hobbyLevels,
    int? level,
    int? currentXP,
    int? totalXP,
    Rank? rank,
    int? streak,
    int? longestStreak,
    int? consecutiveFailedDays,
    DateTime? lastActiveDate,
    bool? onboardingComplete,
    bool clearLastActiveDate = false,
  }) {
    return Player(
      name: name ?? this.name,
      hobbies: hobbies ?? this.hobbies,
      hobbyLevels: hobbyLevels ?? this.hobbyLevels,
      level: level ?? this.level,
      currentXP: currentXP ?? this.currentXP,
      totalXP: totalXP ?? this.totalXP,
      rank: rank ?? this.rank,
      streak: streak ?? this.streak,
      longestStreak: longestStreak ?? this.longestStreak,
      consecutiveFailedDays:
          consecutiveFailedDays ?? this.consecutiveFailedDays,
      lastActiveDate:
          clearLastActiveDate ? null : (lastActiveDate ?? this.lastActiveDate),
      onboardingComplete: onboardingComplete ?? this.onboardingComplete,
    );
  }
}
