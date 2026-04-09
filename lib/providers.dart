import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'models/player.dart';
import 'models/quest.dart';
import 'models/daily_record.dart';
import 'constants/ranks.dart';
import 'services/storage_service.dart';
import 'services/quest_service.dart';
import 'services/notification_service.dart';

// ── Infrastructure ─────────────────────────────────────────────────────────────

final storageServiceProvider = FutureProvider<StorageService>((ref) =>
    StorageService.create());

final notificationServiceProvider = Provider<NotificationService>((ref) {
  final service = NotificationService(FlutterLocalNotificationsPlugin());
  service.init();
  return service;
});

final questServiceProvider = Provider<QuestService>((ref) => QuestService());

// ── Player ─────────────────────────────────────────────────────────────────────

class PlayerNotifier extends StateNotifier<Player> {
  final Ref _ref;

  PlayerNotifier(this._ref) : super(Player.initial()) {
    _load();
  }

  Future<void> _load() async {
    final storage = await _ref.read(storageServiceProvider.future);
    state = await storage.loadPlayer();
  }

  Future<void> _save() async {
    final storage = await _ref.read(storageServiceProvider.future);
    await storage.savePlayer(state);
  }

  Future<void> completeOnboarding({
    required String name,
    required List<String> hobbies,
    required Map<String, String> hobbyLevels,
  }) async {
    state = state.copyWith(
      name: name,
      hobbies: hobbies,
      hobbyLevels: hobbyLevels,
      onboardingComplete: true,
      lastActiveDate: DateTime.now(),
    );
    await _save();
  }

  Future<void> applyQuestComplete(Player updatedPlayer) async {
    state = updatedPlayer;
    await _save();
  }

  Future<void> applyDayTransition(Player updatedPlayer) async {
    state = updatedPlayer;
    await _save();
  }

  Future<void> updateHobbies(
      List<String> hobbies, Map<String, String> levels) async {
    state = state.copyWith(hobbies: hobbies, hobbyLevels: levels);
    await _save();
  }

  Future<void> resetAll() async {
    final storage = await _ref.read(storageServiceProvider.future);
    await storage.clearAll();
    state = Player.initial();
  }
}

final playerProvider =
    StateNotifierProvider<PlayerNotifier, Player>(PlayerNotifier.new);

// ── Daily Quests ───────────────────────────────────────────────────────────────

class DailyQuestsNotifier extends StateNotifier<List<Quest>> {
  final Ref _ref;

  DailyQuestsNotifier(this._ref) : super([]) {
    _load();
  }

  Future<void> _load() async {
    final storage = await _ref.read(storageServiceProvider.future);
    final quests = await storage.loadDailyQuests();
    if (quests != null) {
      state = quests;
    } else {
      // Need to regenerate — wait for player to load first
      await Future.delayed(const Duration(milliseconds: 100));
      final player = _ref.read(playerProvider);
      if (player.onboardingComplete) {
        await regenerate(player);
      }
    }
  }

  Future<void> regenerate(Player player) async {
    final service = _ref.read(questServiceProvider);
    final quests = await service.generateDailyQuests(player, DateTime.now());
    final storage = await _ref.read(storageServiceProvider.future);
    await storage.saveDailyQuests(quests, DateTime.now());
    state = quests;
  }

  Future<void> markCompleted(String id) async {
    state = state.map((q) {
      if (q.id == id) return q.copyWith(isCompleted: true);
      return q;
    }).toList();

    final storage = await _ref.read(storageServiceProvider.future);
    await storage.saveDailyQuests(state, DateTime.now());

    // Update player XP
    final quest = state.firstWhere((q) => q.id == id);
    final player = _ref.read(playerProvider);
    final service = _ref.read(questServiceProvider);
    final result = service.completeQuest(player, quest);
    await _ref.read(playerProvider.notifier).applyQuestComplete(result.player);

    if (result.rankUp) {
      _ref.read(rankUpProvider.notifier).state = result.newRank;
    }
  }
}

final dailyQuestsProvider =
    StateNotifierProvider<DailyQuestsNotifier, List<Quest>>(
        DailyQuestsNotifier.new);

// ── History ────────────────────────────────────────────────────────────────────

final historyProvider = FutureProvider<List<DailyRecord>>((ref) async {
  final storage = await ref.read(storageServiceProvider.future);
  return storage.loadHistory();
});

// ── UI State ───────────────────────────────────────────────────────────────────

final notificationsEnabledProvider = StateProvider<bool>((ref) => true);

/// 0 = hidden; positive value = penalty amount to display.
final penaltyBannerProvider = StateProvider<int>((ref) => 0);

/// Non-null while rank-up modal should be shown.
final rankUpProvider = StateProvider<Rank?>((ref) => null);

/// Non-null while demotion modal should be shown (holds the OLD rank).
final demotionProvider = StateProvider<Rank?>((ref) => null);
