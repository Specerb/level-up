import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/theme.dart';
import '../constants/ranks.dart';
import '../providers.dart';
import 'rank_badge.dart';

class RankUpModal extends ConsumerWidget {
  final Rank newRank;

  const RankUpModal({super.key, required this.newRank});

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
              '[ RANK UP ]',
              style: GoogleFonts.spaceMono(
                color: kGold,
                fontSize: 12,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'YOU HAVE BEEN\nPROMOTED',
              textAlign: TextAlign.center,
              style: GoogleFonts.rajdhani(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
                height: 1.1,
              ),
            ),
            const SizedBox(height: 24),
            RankBadge(rank: newRank, fontSize: 14),
            const SizedBox(height: 28),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () =>
                    ref.read(rankUpProvider.notifier).state = null,
                child: const Text('CONTINUE'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
