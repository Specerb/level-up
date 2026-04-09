import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/ranks.dart';

class RankBadge extends StatelessWidget {
  final Rank rank;
  final double fontSize;

  const RankBadge({super.key, required this.rank, this.fontSize = 12});

  @override
  Widget build(BuildContext context) {
    final color = rankColors[rank]!;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        border: Border.all(color: color),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        'RANK ${rank.name}',
        style: GoogleFonts.spaceMono(
          color: color,
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          letterSpacing: 1,
        ),
      ),
    );
  }
}
