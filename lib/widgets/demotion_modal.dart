import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/theme.dart';
import '../constants/ranks.dart';
import '../providers.dart';
import 'rank_badge.dart';

class DemotionModal extends ConsumerWidget {
  final Rank currentRank;

  const DemotionModal({super.key, required this.currentRank});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dialog(
      backgroundColor: kSurface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '[ RANK LOST ]',
              style: GoogleFonts.spaceMono(
                color: kDanger,
                fontSize: 12,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'YOU HAVE BEEN\nDEMOTED',
              textAlign: TextAlign.center,
              style: GoogleFonts.rajdhani(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
                height: 1.1,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Consecutive failures have a price.',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                color: Colors.grey.shade500,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 24),
            RankBadge(rank: currentRank, fontSize: 14),
            const SizedBox(height: 28),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () =>
                    ref.read(demotionProvider.notifier).state = null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: kDanger,
                  foregroundColor: Colors.white,
                ),
                child: const Text('ACKNOWLEDGED'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
