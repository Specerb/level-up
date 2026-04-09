import '../constants/difficulties.dart';

class QuestTemplate {
  final String title;
  final String description;
  final String hobby;
  final Difficulty difficulty;

  const QuestTemplate({
    required this.title,
    required this.description,
    required this.hobby,
    required this.difficulty,
  });
}

const List<QuestTemplate> questLibrary = [
  // ── GYM ─────────────────────────────────────────────────────────────────────
  QuestTemplate(
    title: 'Warm-Up Session',
    description: 'Complete a 15-minute warm-up: jump rope, dynamic stretches, and light cardio.',
    hobby: 'gym',
    difficulty: Difficulty.easy,
  ),
  QuestTemplate(
    title: 'Push Day',
    description: 'Complete 5 sets of bench press, overhead press, and tricep pushdowns.',
    hobby: 'gym',
    difficulty: Difficulty.medium,
  ),
  QuestTemplate(
    title: 'Pull Day',
    description: 'Complete 5 sets each of pull-ups, barbell rows, and bicep curls.',
    hobby: 'gym',
    difficulty: Difficulty.medium,
  ),
  QuestTemplate(
    title: 'Leg Day',
    description: 'Squat, Romanian deadlift, and leg press — 4 sets each. No skipping.',
    hobby: 'gym',
    difficulty: Difficulty.hard,
  ),
  QuestTemplate(
    title: 'One Rep Max',
    description: 'Attempt a new 1RM on bench press or squat. Log your result and celebrate progress.',
    hobby: 'gym',
    difficulty: Difficulty.hard,
  ),
  QuestTemplate(
    title: 'The Iron Century',
    description: '100 push-ups, 100 squats, 100 sit-ups. Spread across the day if needed — just finish.',
    hobby: 'gym',
    difficulty: Difficulty.legendary,
  ),

  // ── RUNNING ──────────────────────────────────────────────────────────────────
  QuestTemplate(
    title: 'Morning Mile',
    description: 'Run 1 mile at a comfortable pace before 10am.',
    hobby: 'running',
    difficulty: Difficulty.easy,
  ),
  QuestTemplate(
    title: 'Tempo 5K',
    description: 'Run 5km at your tempo pace — uncomfortable but sustainable.',
    hobby: 'running',
    difficulty: Difficulty.medium,
  ),
  QuestTemplate(
    title: 'Interval Sprints',
    description: '8 × 400m repeats with 90 seconds rest between each. Track your splits.',
    hobby: 'running',
    difficulty: Difficulty.hard,
  ),
  QuestTemplate(
    title: 'Long Run',
    description: 'Run 15km at an easy, conversational pace. Hydrate and enjoy the distance.',
    hobby: 'running',
    difficulty: Difficulty.legendary,
  ),

  // ── CYCLING ──────────────────────────────────────────────────────────────────
  QuestTemplate(
    title: 'Easy Spin',
    description: 'Ride for 20 minutes at low resistance — recovery pace, keep cadence above 80 rpm.',
    hobby: 'cycling',
    difficulty: Difficulty.easy,
  ),
  QuestTemplate(
    title: 'Hill Repeats',
    description: 'Find a climb and complete 5 repeats, focusing on keeping form under fatigue.',
    hobby: 'cycling',
    difficulty: Difficulty.medium,
  ),
  QuestTemplate(
    title: 'Endurance Ride',
    description: 'Complete a 40km ride. Maintain a steady effort and track avg speed.',
    hobby: 'cycling',
    difficulty: Difficulty.hard,
  ),

  // ── SWIMMING ─────────────────────────────────────────────────────────────────
  QuestTemplate(
    title: 'Lap Drill',
    description: 'Swim 10 laps focusing on one specific technique: catch, rotation, or kick.',
    hobby: 'swimming',
    difficulty: Difficulty.easy,
  ),
  QuestTemplate(
    title: 'Mixed Strokes',
    description: 'Swim 1km alternating freestyle and backstroke every 100m.',
    hobby: 'swimming',
    difficulty: Difficulty.medium,
  ),
  QuestTemplate(
    title: 'Endurance Swim',
    description: 'Complete 2km non-stop at a steady, controlled pace.',
    hobby: 'swimming',
    difficulty: Difficulty.hard,
  ),

  // ── HIKING ───────────────────────────────────────────────────────────────────
  QuestTemplate(
    title: 'Neighborhood Walk',
    description: 'Walk 5km outdoors. No music — pay attention to your surroundings.',
    hobby: 'hiking',
    difficulty: Difficulty.easy,
  ),
  QuestTemplate(
    title: 'Trail Hike',
    description: 'Find a local trail and complete a 10km hike with at least 200m elevation.',
    hobby: 'hiking',
    difficulty: Difficulty.medium,
  ),
  QuestTemplate(
    title: 'Summit Day',
    description: 'Hike a route with 800m+ elevation gain. Take a photo at the top.',
    hobby: 'hiking',
    difficulty: Difficulty.hard,
  ),

  // ── YOGA ─────────────────────────────────────────────────────────────────────
  QuestTemplate(
    title: 'Morning Flow',
    description: 'Complete a 15-minute morning yoga flow. Focus on breath and presence.',
    hobby: 'yoga',
    difficulty: Difficulty.easy,
  ),
  QuestTemplate(
    title: 'Balance Challenge',
    description: 'Hold tree pose, warrior III, and eagle pose for 60 seconds each side.',
    hobby: 'yoga',
    difficulty: Difficulty.medium,
  ),
  QuestTemplate(
    title: 'Full Practice',
    description: 'Complete a 60-minute full-body yoga session including inversions and deep stretches.',
    hobby: 'yoga',
    difficulty: Difficulty.hard,
  ),

  // ── CALISTHENICS ─────────────────────────────────────────────────────────────
  QuestTemplate(
    title: 'Core Circuit',
    description: '3 rounds: 20 hollow body rocks, 30s plank, 15 leg raises.',
    hobby: 'calisthenics',
    difficulty: Difficulty.easy,
  ),
  QuestTemplate(
    title: 'Push-Up Pyramid',
    description: '1 push-up, 2 push-ups... up to 10, then back down. Rest only between sets.',
    hobby: 'calisthenics',
    difficulty: Difficulty.medium,
  ),
  QuestTemplate(
    title: 'Handstand Practice',
    description: 'Spend 20 minutes on handstand training: wall holds, kick-ups, and shoulder shrugs.',
    hobby: 'calisthenics',
    difficulty: Difficulty.hard,
  ),
  QuestTemplate(
    title: 'Muscle-Up Quest',
    description: 'Achieve your first muscle-up, or complete 10 if you already can. No kipping.',
    hobby: 'calisthenics',
    difficulty: Difficulty.legendary,
  ),

  // ── MARTIAL ARTS ─────────────────────────────────────────────────────────────
  QuestTemplate(
    title: 'Shadow Boxing',
    description: '3 × 3-minute rounds of shadow boxing. Focus on footwork and combinations.',
    hobby: 'martial arts',
    difficulty: Difficulty.easy,
  ),
  QuestTemplate(
    title: 'Drilling Session',
    description: 'Drill one specific technique 100 times with a partner or on a bag.',
    hobby: 'martial arts',
    difficulty: Difficulty.medium,
  ),
  QuestTemplate(
    title: 'Sparring Session',
    description: 'Complete 5 × 3-minute sparring rounds. Focus on applying techniques, not winning.',
    hobby: 'martial arts',
    difficulty: Difficulty.hard,
  ),

  // ── DRAWING ──────────────────────────────────────────────────────────────────
  QuestTemplate(
    title: 'Gesture Sketches',
    description: 'Draw 20 gesture sketches (30–60 seconds each). Use a reference site or app.',
    hobby: 'drawing',
    difficulty: Difficulty.easy,
  ),
  QuestTemplate(
    title: 'Still Life Study',
    description: 'Set up 3 objects and draw them with accurate proportions and shading.',
    hobby: 'drawing',
    difficulty: Difficulty.medium,
  ),
  QuestTemplate(
    title: 'Portrait From Reference',
    description: 'Draw a detailed portrait from a photo reference. Spend at least 45 minutes.',
    hobby: 'drawing',
    difficulty: Difficulty.hard,
  ),

  // ── PAINTING ─────────────────────────────────────────────────────────────────
  QuestTemplate(
    title: 'Color Mixing Study',
    description: 'Mix and swatch 12 color combinations. Document what you discover.',
    hobby: 'painting',
    difficulty: Difficulty.easy,
  ),
  QuestTemplate(
    title: 'Landscape Study',
    description: 'Paint a landscape from a reference photo. Focus on values and atmosphere.',
    hobby: 'painting',
    difficulty: Difficulty.medium,
  ),
  QuestTemplate(
    title: 'Complete a Canvas',
    description: 'Finish a painting you've started, or complete a new one start-to-finish in one session.',
    hobby: 'painting',
    difficulty: Difficulty.hard,
  ),

  // ── PHOTOGRAPHY ──────────────────────────────────────────────────────────────
  QuestTemplate(
    title: 'One Subject Rule',
    description: 'Photograph one subject 20 different ways: angles, light, depth, framing.',
    hobby: 'photography',
    difficulty: Difficulty.easy,
  ),
  QuestTemplate(
    title: 'Golden Hour Shoot',
    description: 'Shoot during the hour before sunset. Edit your 3 best shots.',
    hobby: 'photography',
    difficulty: Difficulty.medium,
  ),
  QuestTemplate(
    title: 'Photo Essay',
    description: 'Create a 10-image photo essay on a theme of your choice. Tell a coherent story.',
    hobby: 'photography',
    difficulty: Difficulty.hard,
  ),

  // ── MUSIC ────────────────────────────────────────────────────────────────────
  QuestTemplate(
    title: 'Scale Practice',
    description: 'Run through your major, minor, and pentatonic scales for 15 minutes.',
    hobby: 'music',
    difficulty: Difficulty.easy,
  ),
  QuestTemplate(
    title: 'Learn a Riff',
    description: 'Learn a new riff or short piece from scratch and play it cleanly 5 times through.',
    hobby: 'music',
    difficulty: Difficulty.medium,
  ),
  QuestTemplate(
    title: 'Record a Take',
    description: 'Record yourself performing a full piece or song. Listen back critically.',
    hobby: 'music',
    difficulty: Difficulty.hard,
  ),
  QuestTemplate(
    title: 'Compose Something',
    description: 'Write and record an original piece — at least 1 minute long. Finish it.',
    hobby: 'music',
    difficulty: Difficulty.legendary,
  ),

  // ── WRITING ──────────────────────────────────────────────────────────────────
  QuestTemplate(
    title: 'Morning Pages',
    description: 'Write 3 pages of stream-of-consciousness text. No editing — just write.',
    hobby: 'writing',
    difficulty: Difficulty.easy,
  ),
  QuestTemplate(
    title: 'Short Story Prompt',
    description: 'Write a 500-word short story using a random prompt. Finish it even if it's rough.',
    hobby: 'writing',
    difficulty: Difficulty.medium,
  ),
  QuestTemplate(
    title: 'Essay Draft',
    description: 'Write a complete first draft of a 1,000-word essay on a topic you care about.',
    hobby: 'writing',
    difficulty: Difficulty.hard,
  ),

  // ── VIDEO EDITING ────────────────────────────────────────────────────────────
  QuestTemplate(
    title: 'Cut a Clip',
    description: 'Edit a 60-second clip from raw footage. Focus on pacing and clean cuts.',
    hobby: 'video editing',
    difficulty: Difficulty.easy,
  ),
  QuestTemplate(
    title: 'Color Grade',
    description: 'Apply a consistent color grade to 5 clips. Match them to look like one scene.',
    hobby: 'video editing',
    difficulty: Difficulty.medium,
  ),
  QuestTemplate(
    title: 'Complete Edit',
    description: 'Produce a finished 3–5 minute video from raw footage to export-ready.',
    hobby: 'video editing',
    difficulty: Difficulty.hard,
  ),

  // ── DANCING ──────────────────────────────────────────────────────────────────
  QuestTemplate(
    title: 'Warm-Up Freestyle',
    description: 'Dance freely to 3 songs. No judgment — just move and warm up.',
    hobby: 'dancing',
    difficulty: Difficulty.easy,
  ),
  QuestTemplate(
    title: 'Choreography Study',
    description: 'Learn and memorize 30 seconds of choreography from a tutorial video.',
    hobby: 'dancing',
    difficulty: Difficulty.medium,
  ),
  QuestTemplate(
    title: 'Full Routine',
    description: 'Learn and perform a complete 2-minute routine. Record it for review.',
    hobby: 'dancing',
    difficulty: Difficulty.hard,
  ),

  // ── READING ──────────────────────────────────────────────────────────────────
  QuestTemplate(
    title: 'Read 20 Pages',
    description: 'Read at least 20 pages of a book. No phone, no interruptions.',
    hobby: 'reading',
    difficulty: Difficulty.easy,
  ),
  QuestTemplate(
    title: 'Deep Reading Session',
    description: 'Read for 60 uninterrupted minutes. Write 3 key takeaways after.',
    hobby: 'reading',
    difficulty: Difficulty.medium,
  ),
  QuestTemplate(
    title: 'Finish the Chapter',
    description: 'Read until the end of the current chapter, no matter how long it is.',
    hobby: 'reading',
    difficulty: Difficulty.medium,
  ),
  QuestTemplate(
    title: 'Finish the Book',
    description: 'Read until you finish the book you\'re currently on. However long it takes.',
    hobby: 'reading',
    difficulty: Difficulty.hard,
  ),

  // ── CHESS ────────────────────────────────────────────────────────────────────
  QuestTemplate(
    title: 'Tactics Puzzles',
    description: 'Solve 10 chess tactics puzzles. Focus on calculation, not speed.',
    hobby: 'chess',
    difficulty: Difficulty.easy,
  ),
  QuestTemplate(
    title: 'Endgame Study',
    description: 'Study one endgame technique (king + pawn, rook endings) for 30 minutes.',
    hobby: 'chess',
    difficulty: Difficulty.medium,
  ),
  QuestTemplate(
    title: 'Annotated Game',
    description: 'Play a rated game then annotate it — identify your 3 biggest mistakes.',
    hobby: 'chess',
    difficulty: Difficulty.hard,
  ),

  // ── MEDITATION ───────────────────────────────────────────────────────────────
  QuestTemplate(
    title: 'Breath Awareness',
    description: 'Sit and focus on your breath for 10 minutes. Gently return when you wander.',
    hobby: 'meditation',
    difficulty: Difficulty.easy,
  ),
  QuestTemplate(
    title: 'Body Scan',
    description: 'Complete a 20-minute body scan meditation from head to toe.',
    hobby: 'meditation',
    difficulty: Difficulty.medium,
  ),
  QuestTemplate(
    title: 'Extended Sit',
    description: 'Meditate for 45 continuous minutes without a guided track.',
    hobby: 'meditation',
    difficulty: Difficulty.hard,
  ),

  // ── LANGUAGE LEARNING ────────────────────────────────────────────────────────
  QuestTemplate(
    title: 'Daily Vocabulary',
    description: 'Learn and review 10 new words in your target language using flashcards.',
    hobby: 'language learning',
    difficulty: Difficulty.easy,
  ),
  QuestTemplate(
    title: 'Speaking Practice',
    description: 'Have a 15-minute conversation with a native speaker or language partner.',
    hobby: 'language learning',
    difficulty: Difficulty.medium,
  ),
  QuestTemplate(
    title: 'Immersion Session',
    description: 'Consume 60 minutes of content in your target language (podcast, film, or book).',
    hobby: 'language learning',
    difficulty: Difficulty.hard,
  ),

  // ── JOURNALING ───────────────────────────────────────────────────────────────
  QuestTemplate(
    title: 'Gratitude Log',
    description: 'Write 5 things you\'re grateful for today. Be specific.',
    hobby: 'journaling',
    difficulty: Difficulty.easy,
  ),
  QuestTemplate(
    title: 'Reflection Entry',
    description: 'Write a full journal entry about this week: wins, struggles, and what you learned.',
    hobby: 'journaling',
    difficulty: Difficulty.medium,
  ),
  QuestTemplate(
    title: 'Future Letter',
    description: 'Write a letter to yourself 1 year from now. Describe who you want to become.',
    hobby: 'journaling',
    difficulty: Difficulty.hard,
  ),

  // ── PROGRAMMING ──────────────────────────────────────────────────────────────
  QuestTemplate(
    title: 'Fix a Bug',
    description: 'Find and fix one bug in a personal project. Write a brief note about the root cause.',
    hobby: 'programming',
    difficulty: Difficulty.easy,
  ),
  QuestTemplate(
    title: 'Code Review',
    description: 'Review your own code from last week. Refactor at least one thing.',
    hobby: 'programming',
    difficulty: Difficulty.medium,
  ),
  QuestTemplate(
    title: 'Ship a Feature',
    description: 'Design and implement one complete feature in a personal or open-source project.',
    hobby: 'programming',
    difficulty: Difficulty.hard,
  ),
  QuestTemplate(
    title: 'Build Something New',
    description: 'Start and finish a mini-project in one sitting. Deploy or share it when done.',
    hobby: 'programming',
    difficulty: Difficulty.legendary,
  ),

  // ── COOKING ──────────────────────────────────────────────────────────────────
  QuestTemplate(
    title: 'Prep Day',
    description: 'Meal prep 3+ meals for the week. Label and store everything properly.',
    hobby: 'cooking',
    difficulty: Difficulty.easy,
  ),
  QuestTemplate(
    title: 'New Recipe',
    description: 'Cook a recipe you\'ve never made before. Follow it precisely on the first try.',
    hobby: 'cooking',
    difficulty: Difficulty.medium,
  ),
  QuestTemplate(
    title: 'Multi-Course Meal',
    description: 'Cook a 3-course meal (starter, main, dessert) from scratch for yourself or others.',
    hobby: 'cooking',
    difficulty: Difficulty.hard,
  ),

  // ── BAKING ───────────────────────────────────────────────────────────────────
  QuestTemplate(
    title: 'Quick Batch',
    description: 'Bake a simple recipe (cookies, muffins) and share some with someone.',
    hobby: 'baking',
    difficulty: Difficulty.easy,
  ),
  QuestTemplate(
    title: 'Yeast Bread',
    description: 'Make a loaf of bread from scratch including kneading and proofing.',
    hobby: 'baking',
    difficulty: Difficulty.medium,
  ),
  QuestTemplate(
    title: 'Layered Cake',
    description: 'Bake and decorate a layered cake. Focus on even layers and smooth frosting.',
    hobby: 'baking',
    difficulty: Difficulty.hard,
  ),

  // ── GAMING ───────────────────────────────────────────────────────────────────
  QuestTemplate(
    title: 'Daily Challenge',
    description: 'Complete the daily challenge or mission in a game you\'re currently playing.',
    hobby: 'gaming',
    difficulty: Difficulty.easy,
  ),
  QuestTemplate(
    title: 'Ranked Session',
    description: 'Play 5 ranked matches or competitive games. Focus on improvement, not winning.',
    hobby: 'gaming',
    difficulty: Difficulty.medium,
  ),
  QuestTemplate(
    title: 'Boss Rush',
    description: 'Defeat a difficult boss or complete a challenging section you\'ve been putting off.',
    hobby: 'gaming',
    difficulty: Difficulty.hard,
  ),

  // ── 3D PRINTING ──────────────────────────────────────────────────────────────
  QuestTemplate(
    title: 'Print a Model',
    description: 'Slice and print a model from a library. Check bed adhesion and first layer.',
    hobby: '3D printing',
    difficulty: Difficulty.easy,
  ),
  QuestTemplate(
    title: 'Design a Part',
    description: 'Model a simple functional object in your CAD software and print it.',
    hobby: '3D printing',
    difficulty: Difficulty.medium,
  ),
  QuestTemplate(
    title: 'Multi-Part Assembly',
    description: 'Design and print a multi-component assembly that requires fitting and post-processing.',
    hobby: '3D printing',
    difficulty: Difficulty.hard,
  ),

  // ── ELECTRONICS ──────────────────────────────────────────────────────────────
  QuestTemplate(
    title: 'Circuit Build',
    description: 'Build a simple circuit on a breadboard from a schematic. Verify it works.',
    hobby: 'electronics',
    difficulty: Difficulty.easy,
  ),
  QuestTemplate(
    title: 'Solder Project',
    description: 'Complete a through-hole soldering project kit from start to finish.',
    hobby: 'electronics',
    difficulty: Difficulty.medium,
  ),
  QuestTemplate(
    title: 'Microcontroller Project',
    description: 'Write and deploy firmware to a microcontroller to solve a real problem.',
    hobby: 'electronics',
    difficulty: Difficulty.hard,
  ),

  // ── CLIMBING ─────────────────────────────────────────────────────────────────
  QuestTemplate(
    title: 'Warm-Up Routes',
    description: 'Complete 5 easy routes, focusing on footwork and body positioning.',
    hobby: 'climbing',
    difficulty: Difficulty.easy,
  ),
  QuestTemplate(
    title: 'Project Route',
    description: 'Work a route at your limit. Make at least 5 serious attempts.',
    hobby: 'climbing',
    difficulty: Difficulty.medium,
  ),
  QuestTemplate(
    title: 'Send Day',
    description: 'Send (complete) a route you\'ve been projecting. Trust your training.',
    hobby: 'climbing',
    difficulty: Difficulty.hard,
  ),

  // ── CAMPING ──────────────────────────────────────────────────────────────────
  QuestTemplate(
    title: 'Kit Check',
    description: 'Inventory your camping gear. Repair or replace anything that is worn out.',
    hobby: 'camping',
    difficulty: Difficulty.easy,
  ),
  QuestTemplate(
    title: 'Day Trip',
    description: 'Plan and execute a day trip to a natural area. Navigate without GPS.',
    hobby: 'camping',
    difficulty: Difficulty.medium,
  ),
  QuestTemplate(
    title: 'Overnight Solo',
    description: 'Camp overnight alone. Cook your own food, set up without help, leave no trace.',
    hobby: 'camping',
    difficulty: Difficulty.hard,
  ),

  // ── SKATEBOARDING ────────────────────────────────────────────────────────────
  QuestTemplate(
    title: 'Flat Ground Practice',
    description: 'Practice your current best trick 50 times. Focus on consistency.',
    hobby: 'skateboarding',
    difficulty: Difficulty.easy,
  ),
  QuestTemplate(
    title: 'New Trick Attempt',
    description: 'Spend 30 minutes attempting a trick you can\'t yet land. Film your attempts.',
    hobby: 'skateboarding',
    difficulty: Difficulty.medium,
  ),
  QuestTemplate(
    title: 'Skate Park Session',
    description: 'Skate for 90 minutes at a park. Land something new before you leave.',
    hobby: 'skateboarding',
    difficulty: Difficulty.hard,
  ),

  // ── FISHING ──────────────────────────────────────────────────────────────────
  QuestTemplate(
    title: 'Rig and Cast',
    description: 'Set up your gear and spend 30 minutes practicing your cast technique.',
    hobby: 'fishing',
    difficulty: Difficulty.easy,
  ),
  QuestTemplate(
    title: 'Two-Hour Session',
    description: 'Fish for at least 2 hours. Keep a log of conditions and any catches.',
    hobby: 'fishing',
    difficulty: Difficulty.medium,
  ),
  QuestTemplate(
    title: 'Dawn Patrol',
    description: 'Arrive before sunrise. Fish the golden hour and stay through mid-morning.',
    hobby: 'fishing',
    difficulty: Difficulty.hard,
  ),
];

/// Returns all quest templates matching a player's hobby via case-insensitive substring match.
List<QuestTemplate> getQuestsForHobby(String hobby) {
  final lower = hobby.toLowerCase();
  return questLibrary.where((q) {
    final qLower = q.hobby.toLowerCase();
    return qLower.contains(lower) || lower.contains(qLower);
  }).toList();
}
