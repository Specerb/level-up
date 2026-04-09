enum Difficulty { easy, medium, hard, legendary }

const Map<Difficulty, int> xpRewards = {
  Difficulty.easy: 50,
  Difficulty.medium: 100,
  Difficulty.hard: 200,
  Difficulty.legendary: 500,
};

const Map<Difficulty, double> penaltyRates = {
  Difficulty.easy: 0.10,
  Difficulty.medium: 0.15,
  Difficulty.hard: 0.20,
  Difficulty.legendary: 0.25,
};

int penaltyXP(Difficulty d) =>
    (xpRewards[d]! * penaltyRates[d]!).round();

String difficultyLabel(Difficulty d) => d.name.toUpperCase();
