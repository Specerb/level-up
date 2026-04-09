import 'package:flutter/material.dart';
import 'theme.dart';

enum Rank { E, D, C, B, A, S }

const Map<Rank, int> rankThresholds = {
  Rank.E: 0,
  Rank.D: 500,
  Rank.C: 1500,
  Rank.B: 3500,
  Rank.A: 7000,
  Rank.S: 15000,
};

const Map<Rank, Color> rankColors = {
  Rank.E: Colors.grey,
  Rank.D: const Color(0xFF4CAF50),
  Rank.C: const Color(0xFF2196F3),
  Rank.B: const Color(0xFF9C27B0),
  Rank.A: kGold,
  Rank.S: kDanger,
};

Rank rankFromXP(int totalXP) {
  Rank result = Rank.E;
  for (final entry in rankThresholds.entries) {
    if (totalXP >= entry.value) {
      result = entry.key;
    }
  }
  return result;
}

/// Returns the XP threshold of the next rank, or -1 if already S rank.
int xpForNextRank(Rank rank) {
  final index = Rank.values.indexOf(rank);
  if (index >= Rank.values.length - 1) return -1;
  final nextRank = Rank.values[index + 1];
  return rankThresholds[nextRank]!;
}

/// XP earned within the current rank tier.
int xpIntoCurrentRank(int totalXP) {
  final rank = rankFromXP(totalXP);
  return totalXP - rankThresholds[rank]!;
}

/// Total XP span of the current rank tier (current threshold → next threshold).
int xpRequiredForCurrentRank(Rank rank) {
  final next = xpForNextRank(rank);
  if (next == -1) return 1; // S rank — return 1 to avoid division by zero
  return next - rankThresholds[rank]!;
}

/// Fill fraction for the XP bar. Clamped [0.0, 1.0].
double xpBarFraction(int totalXP) {
  final rank = rankFromXP(totalXP);
  if (rank == Rank.S) return 1.0;
  final into = xpIntoCurrentRank(totalXP);
  final required = xpRequiredForCurrentRank(rank);
  return (into / required).clamp(0.0, 1.0);
}

Rank demoteRank(Rank rank) {
  final index = Rank.values.indexOf(rank);
  return index > 0 ? Rank.values[index - 1] : rank;
}

int demotionThreshold(Rank rank) {
  switch (rank) {
    case Rank.D:
    case Rank.C:
      return 7;
    case Rank.B:
    case Rank.A:
      return 5;
    case Rank.S:
      return 3;
    default:
      return 0; // E rank — no demotion
  }
}
