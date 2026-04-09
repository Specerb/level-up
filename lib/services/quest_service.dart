import 'dart:math';
import '../models/player.dart';
import '../models/quest.dart';
import '../models/daily_record.dart';
import '../constants/difficulties.dart';
import '../constants/ranks.dart';
import 'quest_library.dart';

class CompleteQuestResult {
  final Player player;
  final bool rankUp;
  final Rank newRank;

  const CompleteQuestResult({
    required this.player,
    required this.rankUp,
    required this.newRank,
  });
}

class DayTransitionResult {
  final Player player;
  final DailyRecord record;
  final int penaltyApplied;
  final Rank? demotedFrom; // non-null when player was demoted

  const DayTransitionResult({
    required this.player,
    required this.record,
    required this.penaltyApplied,
    this.demotedFrom,
  });
}

class QuestService {
  List<Difficulty> _poolForSkillLevel(String level, int playerLevel) {
    switch (level.toLowerCase()) {
      case 'intermediate':
        return [Difficulty.easy, Difficulty.medium];
      case 'advanced':
        final pool = [Difficulty.medium, Difficulty.hard];
        if (playerLevel >= 20) pool.add(Difficulty.legendary);
        return pool;
      default: // beginner
        return [Difficulty.easy];
    }
  }

  int _questCountForDate(DateTime date) {
    final seed = date.year * 10000 + date.month * 100 + date.day;
    return Random(seed).nextBool() ? 2 : 1;
  }

  Future<List<Quest>> generateDailyQuests(
      Player player, DateTime date) async {
    if (player.hobbies.isEmpty) return [];

    final seed = date.year * 10000 + date.month * 100 + date.day;
    final rng = Random(seed);
    final count = _questCountForDate(date);

    final List<Quest> result = [];
    final List<String> usedHobbies = [];

    for (int i = 0; i < count; i++) {
      // Prefer different hobbies when generating 2 quests
      List<String> available = (count == 2 && usedHobbies.isNotEmpty)
          ? player.hobbies.where((h) => !usedHobbies.contains(h)).toList()
          : List<String>.from(player.hobbies);

      if (available.isEmpty) available = List<String>.from(player.hobbies);

      final hobby = available[rng.nextInt(available.length)];
      final skillLevel = player.hobbyLevels[hobby] ?? 'beginner';
      final pool = _poolForSkillLevel(skillLevel, player.level);
      final difficulty = pool[rng.nextInt(pool.length)];

      final templates = getQuestsForHobby(hobby)
          .where((t) => t.difficulty == difficulty)
          .toList();

      if (templates.isEmpty) continue;

      final template = templates[rng.nextInt(templates.length)];
      result.add(Quest(
        id: '${date.year}${date.month.toString().padLeft(2, '0')}${date.day.toString().padLeft(2, '0')}_$i',
        title: template.title,
        description: template.description,
        hobby: hobby,
        difficulty: difficulty,
        isCompleted: false,
        xpReward: xpRewards[difficulty]!,
        penaltyXp: penaltyXP(difficulty),
      ));
      usedHobbies.add(hobby);
    }

    return result;
  }

  /// Called at app startup when the date has changed since last active.
  DayTransitionResult processDayTransition({
    required Player player,
    required List<Quest> previousQuests,
    required DateTime previousDate,
    required DateTime today,
  }) {
    final completedCount = previousQuests.where((q) => q.isCompleted).length;
    final allCompleted =
        completedCount == previousQuests.length && previousQuests.isNotEmpty;
    final noneCompleted =
        completedCount == 0 && previousQuests.isNotEmpty;

    int xpDelta = 0;
    int penaltyApplied = 0;
    Rank? demotedFrom;

    // Apply XP penalty when no quests were completed
    if (noneCompleted) {
      penaltyApplied =
          previousQuests.fold(0, (sum, q) => sum + q.penaltyXp);
      xpDelta = -penaltyApplied;
    }

    // Streak
    int newStreak;
    if (allCompleted) {
      newStreak = player.streak + 1;
    } else if (noneCompleted) {
      newStreak = 0;
    } else {
      newStreak = player.streak;
    }
    final newLongestStreak = max(newStreak, player.longestStreak);

    // Consecutive failed days
    int newConsecutiveFailed =
        noneCompleted ? player.consecutiveFailedDays + 1 : 0;

    // Demotion check
    Rank newRank = player.rank;
    final threshold = demotionThreshold(player.rank);
    if (threshold > 0 && newConsecutiveFailed >= threshold) {
      demotedFrom = player.rank;
      newRank = demoteRank(player.rank);
      newConsecutiveFailed = 0;
      // Set totalXP to the floor of the new rank
      xpDelta += rankThresholds[newRank]! - player.totalXP;
    }

    final newTotalXP = max(0, player.totalXP + xpDelta);
    final finalRank = rankFromXP(newTotalXP);
    final newLevel = max(1, 1 + newTotalXP ~/ 1000);

    final record = DailyRecord.fromDay(previousDate, previousQuests);

    final updatedPlayer = player.copyWith(
      totalXP: newTotalXP,
      currentXP: newTotalXP - (rankThresholds[finalRank] ?? 0),
      rank: finalRank,
      level: newLevel,
      streak: newStreak,
      longestStreak: newLongestStreak,
      consecutiveFailedDays: newConsecutiveFailed,
      lastActiveDate: today,
    );

    return DayTransitionResult(
      player: updatedPlayer,
      record: record,
      penaltyApplied: penaltyApplied,
      demotedFrom: demotedFrom,
    );
  }

  CompleteQuestResult completeQuest(Player player, Quest quest) {
    final newTotalXP = player.totalXP + quest.xpReward;
    final newRank = rankFromXP(newTotalXP);
    final rankUp = newRank.index > player.rank.index;
    final newLevel = max(1, 1 + newTotalXP ~/ 1000);

    final updated = player.copyWith(
      totalXP: newTotalXP,
      currentXP: newTotalXP - (rankThresholds[newRank] ?? 0),
      rank: newRank,
      level: newLevel,
      consecutiveFailedDays: 0,
    );

    return CompleteQuestResult(
      player: updated,
      rankUp: rankUp,
      newRank: newRank,
    );
  }

  bool isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;
}
