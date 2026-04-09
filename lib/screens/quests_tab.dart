import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../constants/theme.dart';
import '../constants/ranks.dart';
import '../providers.dart';
import '../widgets/quest_card.dart';
import '../widgets/rank_badge.dart';

class QuestsTab extends ConsumerWidget {
  const QuestsTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final player = ref.watch(playerProvider);
    final quests = ref.watch(dailyQuestsProvider);

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '[ DAILY BRIEF ]',
                            style: GoogleFonts.spaceMono(
                              color: kAccent,
                              fontSize: 11,
                              letterSpacing: 2,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            DateFormat('EEE, MMM d').format(DateTime.now()).toUpperCase(),
                            style: GoogleFonts.rajdhani(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          RankBadge(rank: player.rank),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              const Icon(Icons.local_fire_department,
                                  color: kGold, size: 16),
                              const SizedBox(width: 4),
                              Text(
                                '${player.streak} DAY STREAK',
                                style: GoogleFonts.spaceMono(
                                  color: kGold,
                                  fontSize: 11,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(color: Colors.grey.shade800, height: 1),
            const SizedBox(height: 8),

            // Quest list
            Expanded(
              child: quests.isEmpty
                  ? Center(
                      child: Text(
                        'No quests today.\nComplete onboarding first.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.spaceMono(
                          color: Colors.grey.shade600,
                          fontSize: 12,
                        ),
                      ),
                    )
                  : ListView(
                      children: [
                        ...quests.map((q) => QuestCard(quest: q)),
                        const SizedBox(height: 16),
                        if (quests.every((q) => q.isCompleted))
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Text(
                                '[ ALL OBJECTIVES COMPLETE ]',
                                style: GoogleFonts.spaceMono(
                                  color: kSuccess,
                                  fontSize: 12,
                                  letterSpacing: 1.5,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
