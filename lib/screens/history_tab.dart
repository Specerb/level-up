import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../constants/theme.dart';
import '../models/daily_record.dart';
import '../providers.dart';

class HistoryTab extends ConsumerWidget {
  const HistoryTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyAsync = ref.watch(historyProvider);

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '[ HISTORY ]',
                    style: GoogleFonts.spaceMono(
                      color: kAccent,
                      fontSize: 11,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'TASK LOG',
                    style: GoogleFonts.rajdhani(
                      color: Colors.white,
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                ],
              ),
            ),
            Divider(color: Colors.grey.shade800, height: 1),
            Expanded(
              child: historyAsync.when(
                loading: () => const Center(
                  child: CircularProgressIndicator(color: kAccent),
                ),
                error: (e, _) => Center(
                  child: Text('Error loading history',
                      style: GoogleFonts.spaceMono(color: kDanger)),
                ),
                data: (history) {
                  if (history.isEmpty) {
                    return Center(
                      child: Text(
                        'No history yet.\nComplete your first quest!',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.spaceMono(
                          color: Colors.grey.shade600,
                          fontSize: 12,
                          height: 1.6,
                        ),
                      ),
                    );
                  }

                  final sorted = [...history]
                    ..sort((a, b) => b.date.compareTo(a.date));

                  return ListView.separated(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    itemCount: sorted.length,
                    separatorBuilder: (_, __) =>
                        Divider(color: Colors.grey.shade800, height: 1),
                    itemBuilder: (context, index) {
                      return _RecordRow(record: sorted[index]);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RecordRow extends StatelessWidget {
  final DailyRecord record;

  const _RecordRow({required this.record});

  @override
  Widget build(BuildContext context) {
    final allDone = record.questsCompleted == record.quests.length &&
        record.quests.isNotEmpty;
    final noneDone = record.questsCompleted == 0 && record.quests.isNotEmpty;

    final iconColor = allDone ? kSuccess : (noneDone ? kDanger : Colors.grey);
    final icon = allDone
        ? Icons.check_circle
        : (noneDone ? Icons.cancel : Icons.remove_circle);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 22),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat('MMM d, yyyy').format(record.date).toUpperCase(),
                  style: GoogleFonts.rajdhani(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 3),
                Row(
                  children: [
                    Text(
                      '${record.questsCompleted}/${record.quests.length} TASKS',
                      style: GoogleFonts.spaceMono(
                        color: Colors.grey.shade500,
                        fontSize: 10,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      '+${record.xpEarned} XP',
                      style: GoogleFonts.spaceMono(
                        color: record.xpEarned > 0 ? kAccent : Colors.grey.shade600,
                        fontSize: 10,
                      ),
                    ),
                    if (record.penaltyXp > 0) ...[
                      const SizedBox(width: 10),
                      Text(
                        '-${record.penaltyXp} XP',
                        style: GoogleFonts.spaceMono(
                          color: kDanger,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
