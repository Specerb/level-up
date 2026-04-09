import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/theme.dart';
import '../constants/ranks.dart';
import '../models/player.dart';

class XPBar extends StatelessWidget {
  final Player player;

  const XPBar({super.key, required this.player});

  @override
  Widget build(BuildContext context) {
    final rank = player.rank;
    final into = xpIntoCurrentRank(player.totalXP);
    final required = xpRequiredForCurrentRank(rank);
    final fraction = xpBarFraction(player.totalXP);
    final color = rankColors[rank]!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'XP',
              style: GoogleFonts.spaceMono(
                color: Colors.grey.shade500,
                fontSize: 11,
                letterSpacing: 1,
              ),
            ),
            const Spacer(),
            Text(
              rank == Rank.S ? 'MAX RANK' : '$into / $required',
              style: GoogleFonts.spaceMono(
                color: Colors.grey.shade500,
                fontSize: 11,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: [
                Container(
                  height: 6,
                  width: constraints.maxWidth,
                  decoration: BoxDecoration(
                    color: kSurface,
                    borderRadius: BorderRadius.circular(3),
                    border: Border.all(color: Colors.grey.shade800),
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeOut,
                  height: 6,
                  width: constraints.maxWidth * fraction,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
