const Map<String, List<String>> hobbyCategories = {
  'Fitness': [
    'gym',
    'running',
    'cycling',
    'swimming',
    'hiking',
    'yoga',
    'calisthenics',
    'martial arts',
  ],
  'Creative': [
    'drawing',
    'painting',
    'photography',
    'music',
    'writing',
    'video editing',
    'dancing',
  ],
  'Mental': [
    'reading',
    'chess',
    'meditation',
    'language learning',
    'journaling',
    'programming',
  ],
  'Lifestyle': [
    'cooking',
    'baking',
    'gaming',
    '3D printing',
    'electronics',
    'climbing',
    'camping',
    'skateboarding',
    'fishing',
  ],
};

List<String> get allHobbies =>
    hobbyCategories.values.expand((list) => list).toList();
