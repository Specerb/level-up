import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/theme.dart';
import '../constants/difficulties.dart';
import '../constants/ranks.dart';
import '../models/quest.dart';
import '../providers.dart';
import 'hobby_chip.dart';

class QuestCard extends ConsumerWidget {
  final Quest quest;

  const QuestCard({super.key, required this.quest});

  Color _difficultyColor(Difficulty d) {
    switch (d) {
      case Difficulty.easy:
        return kSuccess;
      case Difficulty.medium:
        return kAccent;
      case Difficulty.hard:
        return kGold;
      case Difficulty.legendary:
        return kDanger;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = _difficultyColor(quest.difficulty);

    return GestureDetector(
      onTap: quest.isCompleted
          ? null
          : () {
              HapticFeedback.mediumImpact();
              ref.read(dailyQuestsProvider.notifier).markCompleted(quest.id);
            },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: kSurface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: quest.isCompleted
                ? kSuccess.withOpacity(0.5)
                : color.withOpacity(0.4),
            width: quest.isCompleted ? 1 : 1.5,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  HobbyChip(
                    hobby: quest.hobby,
                    selected: false,
                    readonly: true,
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.12),
                      border: Border.all(color: color.withOpacity(0.5)),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: Text(
                      difficultyLabel(quest.difficulty),
                      style: GoogleFonts.spaceMono(
                          fontSize: 10, color: color, letterSpacing: 0.5),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          quest.title,
                          style: GoogleFonts.rajdhani(
                            color: quest.isCompleted
                                ? Colors.grey.shade600
                                : Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                            decoration: quest.isCompleted
                                ? TextDecoration.lineThrough
                                : null,
                            decorationColor: Colors.grey.shade600,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          quest.description,
                          style: GoogleFonts.inter(
                            color: quest.isCompleted
                                ? Colors.grey.shade700
                                : Colors.grey.shade400,
                            fontSize: 13,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '+${quest.xpReward} XP',
                        style: GoogleFonts.spaceMono(
                          color: quest.isCompleted
                              ? Colors.grey.shade600
                              : kAccent,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (quest.isCompleted) ...[
                        const SizedBox(height: 8),
                        const Icon(Icons.check_circle, color: kSuccess, size: 24),
                      ] else ...[
                        const SizedBox(height: 8),
                        Text(
                          '-${quest.penaltyXp} XP\nif missed',
                          textAlign: TextAlign.right,
                          style: GoogleFonts.spaceMono(
                            color: Colors.grey.shade700,
                            fontSize: 10,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
              if (!quest.isCompleted) ...[
                const SizedBox(height: 14),
                Center(
                  child: Text(
                    'TAP TO COMPLETE',
                    style: GoogleFonts.spaceMono(
                      color: Colors.grey.shade700,
                      fontSize: 10,
                      letterSpacing: 2,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
