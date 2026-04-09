import 'quest.dart';

class DailyRecord {
  final DateTime date;
  final List<Quest> quests;
  final int questsCompleted;
  final int xpEarned;
  final bool penaltiesApplied;
  final int penaltyXp;

  const DailyRecord({
    required this.date,
    required this.quests,
    required this.questsCompleted,
    required this.xpEarned,
    required this.penaltiesApplied,
    required this.penaltyXp,
  });

  /// Construct from a completed day's quest list.
  factory DailyRecord.fromDay(DateTime date, List<Quest> quests) {
    final completed = quests.where((q) => q.isCompleted).toList();
    final noneCompleted = completed.isEmpty && quests.isNotEmpty;
    final xpEarned = completed.fold(0, (sum, q) => sum + q.xpReward);
    final penaltyXp = noneCompleted
        ? quests.fold(0, (sum, q) => sum + q.penaltyXp)
        : 0;
    return DailyRecord(
      date: date,
      quests: quests,
      questsCompleted: completed.length,
      xpEarned: xpEarned,
      penaltiesApplied: noneCompleted,
      penaltyXp: penaltyXp,
    );
  }

  factory DailyRecord.fromJson(Map<String, dynamic> json) {
    return DailyRecord(
      date: DateTime.parse(json['date'] as String),
      quests: (json['quests'] as List)
          .map((q) => Quest.fromJson(q as Map<String, dynamic>))
          .toList(),
      questsCompleted: json['questsCompleted'] as int? ?? 0,
      xpEarned: json['xpEarned'] as int? ?? 0,
      penaltiesApplied: json['penaltiesApplied'] as bool? ?? false,
      penaltyXp: json['penaltyXp'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        'date': date.toIso8601String(),
        'quests': quests.map((q) => q.toJson()).toList(),
        'questsCompleted': questsCompleted,
        'xpEarned': xpEarned,
        'penaltiesApplied': penaltiesApplied,
        'penaltyXp': penaltyXp,
      };
}
