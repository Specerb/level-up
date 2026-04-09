import '../constants/difficulties.dart';

class Quest {
  final String id;
  final String title;
  final String description;
  final String hobby;
  final Difficulty difficulty;
  final bool isCompleted;
  final int xpReward;
  final int penaltyXp;

  const Quest({
    required this.id,
    required this.title,
    required this.description,
    required this.hobby,
    required this.difficulty,
    required this.isCompleted,
    required this.xpReward,
    required this.penaltyXp,
  });

  factory Quest.fromJson(Map<String, dynamic> json) {
    final difficulty =
        Difficulty.values.byName(json['difficulty'] as String? ?? 'easy');
    return Quest(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      hobby: json['hobby'] as String,
      difficulty: difficulty,
      isCompleted: json['isCompleted'] as bool? ?? false,
      xpReward: json['xpReward'] as int? ?? xpRewards[difficulty]!,
      penaltyXp: json['penaltyXp'] as int? ?? penaltyXP(difficulty),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'hobby': hobby,
        'difficulty': difficulty.name,
        'isCompleted': isCompleted,
        'xpReward': xpReward,
        'penaltyXp': penaltyXp,
      };

  Quest copyWith({
    String? id,
    String? title,
    String? description,
    String? hobby,
    Difficulty? difficulty,
    bool? isCompleted,
    int? xpReward,
    int? penaltyXp,
  }) {
    return Quest(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      hobby: hobby ?? this.hobby,
      difficulty: difficulty ?? this.difficulty,
      isCompleted: isCompleted ?? this.isCompleted,
      xpReward: xpReward ?? this.xpReward,
      penaltyXp: penaltyXp ?? this.penaltyXp,
    );
  }
}
