import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/theme.dart';
import '../providers.dart';

class PenaltyBanner extends ConsumerStatefulWidget {
  final int penaltyAmount;

  const PenaltyBanner({super.key, required this.penaltyAmount});

  @override
  ConsumerState<PenaltyBanner> createState() => _PenaltyBannerState();
}

class _PenaltyBannerState extends ConsumerState<PenaltyBanner> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(seconds: 5), _dismiss);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _dismiss() {
    if (mounted) {
      ref.read(penaltyBannerProvider.notifier).state = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Material(
        color: Colors.transparent,
        child: Container(
          color: kDanger.withOpacity(0.92),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: SafeArea(
            bottom: false,
            child: Row(
              children: [
                const Icon(Icons.warning_amber_rounded,
                    color: Colors.white, size: 20),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    '-${widget.penaltyAmount} XP PENALTY APPLIED',
                    style: GoogleFonts.spaceMono(
                      color: Colors.white,
                      fontSize: 12,
                      letterSpacing: 1,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white, size: 18),
                  onPressed: _dismiss,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
