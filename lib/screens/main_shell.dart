import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/theme.dart';
import '../providers.dart';
import '../services/quest_service.dart';
import '../widgets/rank_up_modal.dart';
import '../widgets/demotion_modal.dart';
import '../widgets/penalty_banner.dart';
import 'quests_tab.dart';
import 'profile_tab.dart';
import 'settings_tab.dart';
import 'coop_tab.dart';
import 'history_tab.dart';

class MainShell extends ConsumerStatefulWidget {
  const MainShell({super.key});

  @override
  ConsumerState<MainShell> createState() => _MainShellState();
}

class _MainShellState extends ConsumerState<MainShell> {
  int _currentIndex = 0;

  static const _tabs = [
    QuestsTab(),
    ProfileTab(),
    SettingsTab(),
    CoopTab(),
    HistoryTab(),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkDayTransition();
    });
  }

  Future<void> _checkDayTransition() async {
    final player = ref.read(playerProvider);
    if (!player.onboardingComplete) return;

    final today = DateTime.now();
    final lastActive = player.lastActiveDate;
    if (lastActive == null) {
      // First ever launch after onboarding — just update date
      await ref.read(playerProvider.notifier).applyDayTransition(
            player.copyWith(lastActiveDate: today),
          );
      return;
    }

    final questService = QuestService();
    if (questService.isSameDay(lastActive, today)) return;

    // A new day has started — load yesterday's quests and process transition
    final storage = await ref.read(storageServiceProvider.future);
    final yesterdayQuests = await storage.loadDailyQuests();

    if (yesterdayQuests != null && yesterdayQuests.isNotEmpty) {
      final result = questService.processDayTransition(
        player: player,
        previousQuests: yesterdayQuests,
        previousDate: lastActive,
        today: today,
      );

      // Archive record
      await storage.appendRecord(result.record);

      // Apply player changes
      await ref
          .read(playerProvider.notifier)
          .applyDayTransition(result.player);

      // Show penalty banner if XP was deducted
      if (result.penaltyApplied > 0) {
        ref.read(penaltyBannerProvider.notifier).state =
            result.penaltyApplied;
      }

      // Show demotion modal if rank dropped
      if (result.demotedFrom != null) {
        ref.read(demotionProvider.notifier).state = result.player.rank;
      }
    }

    // Generate new quests for today
    final updatedPlayer = ref.read(playerProvider);
    await ref.read(dailyQuestsProvider.notifier).regenerate(updatedPlayer);
  }

  @override
  Widget build(BuildContext context) {
    final penalty = ref.watch(penaltyBannerProvider);
    final rankUp = ref.watch(rankUpProvider);
    final demotion = ref.watch(demotionProvider);

    return Scaffold(
      body: Stack(
        children: [
          IndexedStack(
            index: _currentIndex,
            children: _tabs,
          ),
          if (rankUp != null) ...[
            Container(color: Colors.black.withOpacity(0.7)),
            Center(child: RankUpModal(newRank: rankUp)),
          ],
          if (demotion != null) ...[
            Container(color: Colors.black.withOpacity(0.7)),
            Center(child: DemotionModal(currentRank: demotion)),
          ],
          if (penalty > 0) PenaltyBanner(penaltyAmount: penalty),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        items: _navItems,
      ),
    );
  }

  static List<BottomNavigationBarItem> get _navItems => [
        BottomNavigationBarItem(
          icon: const Icon(Icons.assignment_outlined),
          activeIcon: const Icon(Icons.assignment),
          label: 'QUESTS',
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.person_outline),
          activeIcon: const Icon(Icons.person),
          label: 'PROFILE',
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.settings_outlined),
          activeIcon: const Icon(Icons.settings),
          label: 'SETTINGS',
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.group_outlined),
          activeIcon: const Icon(Icons.group),
          label: 'COOP',
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.history_outlined),
          activeIcon: const Icon(Icons.history),
          label: 'HISTORY',
        ),
      ];
}

// ── Overlay wrapper for modals ─────────────────────────────────────────────────

class ModalOverlay extends ConsumerWidget {
  final Widget child;

  const ModalOverlay({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rankUp = ref.watch(rankUpProvider);
    final demotion = ref.watch(demotionProvider);

    if (rankUp != null) {
      return Stack(
        children: [
          child,
          _Barrier(),
          Center(child: RankUpModal(newRank: rankUp)),
        ],
      );
    }

    if (demotion != null) {
      return Stack(
        children: [
          child,
          _Barrier(),
          Center(child: DemotionModal(currentRank: demotion)),
        ],
      );
    }

    return child;
  }
}

class _Barrier extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.black.withOpacity(0.7));
  }
}
