class TrainingExercise {
  final String name;
  final String category; // 'breathing', 'articulation', 'vocal', 'song'
  final int durationMinutes;
  final String description;
  final List<String> steps;
  final List<String> benefits;
  final String? anatomyFocus; // Which muscles/parts are used
  final String difficulty; // 'beginner', 'intermediate', 'advanced'

  const TrainingExercise({
    required this.name,
    required this.category,
    required this.durationMinutes,
    required this.description,
    required this.steps,
    required this.benefits,
    this.anatomyFocus,
    this.difficulty = 'beginner',
  });
}

// Complete library of exercises
class ExerciseLibrary {
  static const List<TrainingExercise> all = [
    // BREATHING EXERCISES
    TrainingExercise(
      name: 'Diaphragmatic Breathing',
      category: 'breathing',
      durationMinutes: 3,
      difficulty: 'beginner',
      anatomyFocus: 'Diaphragm, Intercostal muscles',
      description: 'Deep breathing from your belly, not chest. Foundation of voice control.',
      steps: [
        'Lie down or sit comfortably',
        'Place one hand on chest, one on belly',
        'Breathe in through nose for 4 counts - belly rises, chest stays still',
        'Hold for 2 counts',
        'Exhale through mouth for 6 counts - belly falls',
        'Repeat 10 times',
      ],
      benefits: [
        'Increases lung capacity',
        'Better breath support for speaking',
        'Reduces vocal strain',
        'Calms nervous system',
      ],
    ),
    
    TrainingExercise(
      name: 'Box Breathing (4-4-4-4)',
      category: 'breathing',
      durationMinutes: 2,
      difficulty: 'beginner',
      anatomyFocus: 'Lungs, Diaphragm',
      description: 'Structured breathing pattern for control and focus.',
      steps: [
        'Inhale for 4 counts',
        'Hold breath for 4 counts',
        'Exhale for 4 counts',
        'Hold empty for 4 counts',
        'Repeat 5 times',
      ],
      benefits: [
        'Improves breath control',
        'Enhances focus',
        'Reduces anxiety before dubbing',
      ],
    ),

    // ARTICULATION EXERCISES
    TrainingExercise(
      name: 'Lip Trills',
      category: 'articulation',
      durationMinutes: 2,
      difficulty: 'beginner',
      anatomyFocus: 'Lips, Vocal cords',
      description: 'Vibrating your lips while humming - warms up voice gently.',
      steps: [
        'Relax your lips',
        'Blow air through closed lips to make them vibrate (like a motorboat)',
        'Add voice/humming to the vibration',
        'Slide up and down your vocal range',
        'Do for 30 seconds, rest, repeat 3x',
      ],
      benefits: [
        'Warms up vocal cords safely',
        'Reduces vocal tension',
        'Improves lip flexibility',
      ],
    ),

    TrainingExercise(
      name: 'Tongue Twisters - Plosives (P, B, T, D)',
      category: 'articulation',
      durationMinutes: 5,
      difficulty: 'intermediate',
      anatomyFocus: 'Tongue, Lips, Soft palate',
      description: 'Practice explosive consonants for clarity.',
      steps: [
        'Start SLOW - clarity over speed',
        'Peter Piper picked a peck of pickled peppers (3x)',
        'Betty Botter bought some butter (3x)',
        'Toy boat, toy boat, toy boat (10x fast)',
        'Red lorry, yellow lorry (10x)',
        'Gradually increase speed while maintaining clarity',
      ],
      benefits: [
        'Sharper consonant pronunciation',
        'Better lip-sync timing',
        'Tongue muscle strength',
      ],
    ),

    TrainingExercise(
      name: 'Hindi Conjunct Practice (क्ष, त्र, ज्ञ)',
      category: 'articulation',
      durationMinutes: 5,
      difficulty: 'intermediate',
      anatomyFocus: 'Tongue, Soft palate',
      description: 'Master challenging Hindi consonant clusters.',
      steps: [
        'क्ष: क्षमा, क्षेत्र, दक्षिण (10x each)',
        'त्र: पत्र, यात्रा, नेत्र (10x each)',
        'ज्ञ: ज्ञान, विज्ञान (10x each)',
        'श्र: श्रम, श्रीमान (10x each)',
        'Combine: "ज्ञानी व्यक्ति श्रम करता है" (5x)',
      ],
      benefits: [
        'Hindi articulatory precision',
        'Tongue flexibility',
        'Professional dubbing quality',
      ],
    ),

    // VOCAL EXERCISES
    TrainingExercise(
      name: 'Vocal Siren (Pitch Slides)',
      category: 'vocal',
      durationMinutes: 2,
      difficulty: 'beginner',
      anatomyFocus: 'Vocal cords',
      description: 'Slide smoothly through your vocal range like a siren.',
      steps: [
        'Start at lowest comfortable pitch',
        'Sing "ooo" or "eee"',
        'Slowly slide from low to high pitch (like ambulance siren)',
        'Then high to low',
        'Keep it smooth - no breaks',
        'Repeat 5 times',
      ],
      benefits: [
        'Expands vocal range',
        'Smooths register transitions',
        'Warms up voice',
      ],
    ),

    TrainingExercise(
      name: 'Humming Scale (Sa Re Ga Ma)',
      category: 'vocal',
      durationMinutes: 3,
      difficulty: 'beginner',
      anatomyFocus: 'Vocal cords, Nasal resonance',
      description: 'Practice scales with closed mouth for resonance.',
      steps: [
        'Hum the notes: Sa Re Ga Ma Pa Dha Ni Sa',
        'Feel vibration in your nose/face',
        'Keep jaw relaxed',
        'Go up and down 3x',
        'Then try: Do Re Mi Fa Sol La Ti Do',
      ],
      benefits: [
        'Develops pitch awareness',
        'Enhances nasal resonance',
        'Gentle vocal warm-up',
      ],
    ),

    // SLOW SPEECH PRACTICE
    TrainingExercise(
      name: 'Metronome Reading',
      category: 'speech',
      durationMinutes: 10,
      difficulty: 'intermediate',
      anatomyFocus: 'Entire vocal apparatus',
      description: 'Practice speaking at controlled, measured pace.',
      steps: [
        'Use metronome app (60 BPM to start)',
        'Read aloud from book/script',
        'One syllable per beat',
        'Exaggerate each word clearly',
        'Gradually increase to 80, then 100 BPM',
      ],
      benefits: [
        'Slows down naturally fast speech',
        'Builds pacing awareness',
        'Improves enunciation',
      ],
    ),

    TrainingExercise(
      name: 'Mirror Practice - Mouth Anatomy',
      category: 'articulation',
      durationMinutes: 5,
      difficulty: 'beginner',
      anatomyFocus: 'Lips, Jaw, Tongue visibility',
      description: 'Watch yourself speak to see mouth movements.',
      steps: [
        'Sit in front of mirror',
        'Slowly say vowels: A E I O U',
        'Observe mouth shape for each',
        'Exaggerate movements',
        'Practice tongue twisters while watching',
        'Notice what moves (lips, jaw, tongue)',
      ],
      benefits: [
        'Visual feedback on articulation',
        'Identifies lazy mouth movements',
        'Muscle memory development',
      ],
    ),
  ];

  static List<TrainingExercise> getByCategory(String category) {
    return all.where((ex) => ex.category == category).toList();
  }

  static List<TrainingExercise> getByDifficulty(String difficulty) {
    return all.where((ex) => ex.difficulty == difficulty).toList();
  }
}
