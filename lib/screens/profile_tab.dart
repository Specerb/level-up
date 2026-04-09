import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/theme.dart';
import '../providers.dart';
import '../widgets/rank_badge.dart';
import '../widgets/xp_bar.dart';
import '../widgets/stat_card.dart';
import '../widgets/hobby_chip.dart';

class ProfileTab extends ConsumerWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final player = ref.watch(playerProvider);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '[ PROFILE ]',
                style: GoogleFonts.spaceMono(
                  color: kAccent,
                  fontSize: 11,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                player.name.toUpperCase(),
                style: GoogleFonts.rajdhani(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  height: 1,
                ),
              ),
              const SizedBox(height: 12),
              RankBadge(rank: player.rank),
              const SizedBox(height: 20),
              XPBar(player: player),
              const SizedBox(height: 24),
              Divider(color: Colors.grey.shade800),
              const SizedBox(height: 16),
              Text(
                'STATS',
                style: GoogleFonts.spaceMono(
                  color: Colors.grey.shade600,
                  fontSize: 11,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  StatCard(label: 'LEVEL', value: '${player.level}'),
                  StatCard(label: 'TOTAL XP', value: '${player.totalXP}'),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  StatCard(label: 'STREAK', value: '${player.streak}'),
                  StatCard(label: 'BEST STREAK', value: '${player.longestStreak}'),
                ],
              ),
              const SizedBox(height: 24),
              Divider(color: Colors.grey.shade800),
              const SizedBox(height: 16),
              Text(
                'DISCIPLINES',
                style: GoogleFonts.spaceMono(
                  color: Colors.grey.shade600,
                  fontSize: 11,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 10),
              player.hobbies.isEmpty
                  ? Text(
                      'No disciplines selected.',
                      style: GoogleFonts.inter(
                          color: Colors.grey.shade600, fontSize: 13),
                    )
                  : Wrap(
                      children: player.hobbies.map((h) {
                        return HobbyChip(
                          hobby: h,
                          selected: true,
                          readonly: true,
                        );
                      }).toList(),
                    ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
