import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/theme.dart';

class HobbyChip extends StatelessWidget {
  final String hobby;
  final bool selected;
  final VoidCallback? onTap;
  final bool readonly;

  const HobbyChip({
    super.key,
    required this.hobby,
    this.selected = false,
    this.onTap,
    this.readonly = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: readonly ? null : onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        margin: const EdgeInsets.only(right: 6, bottom: 6),
        decoration: BoxDecoration(
          color: selected ? kAccent.withOpacity(0.15) : kSurface,
          border: Border.all(
            color: selected ? kAccent : Colors.grey.shade700,
            width: selected ? 1.5 : 1,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          hobby.toUpperCase(),
          style: GoogleFonts.spaceMono(
            fontSize: 11,
            color: selected ? kAccent : Colors.grey.shade500,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }
}
