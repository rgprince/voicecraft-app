import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../utils/theme.dart';
import '../models/training_exercise.dart';
import 'exercise_detail_screen.dart';

class PracticeLibraryScreen extends StatefulWidget {
  const PracticeLibraryScreen({super.key});

  @override
  State<PracticeLibraryScreen> createState() => _PracticeLibraryScreenState();
}

class _PracticeLibraryScreenState extends State<PracticeLibraryScreen> {
  String _selectedCategory = 'all';
  String _selectedDifficulty = 'all';

  @override
  Widget build(BuildContext context) {
    final exercises = _getFilteredExercises();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Practice Library'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _showFilters,
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Category filters
          _buildCategoryChips(),
          const SizedBox(height: 24),
          
          // Exercises by category
          _buildCategorySection(
            '🫁 BREATHING',
            Colors.blue,
            exercises.where((e) => e.category == 'breathing').toList(),
          ),
          const SizedBox(height: 16),
          
          _buildCategorySection(
            '👄 ARTICULATION',
            Colors.orange,
            exercises.where((e) => e.category == 'articulation').toList(),
          ),
          const SizedBox(height: 16),
          
          _buildCategorySection(
            '🎵 VOCAL',
            Colors.purple,
            exercises.where((e) => e.category == 'vocal').toList(),
          ),
          const SizedBox(height: 16),
          
          _buildCategorySection(
            '🗣️ SPEECH',
            Colors.green,
            exercises.where((e) => e.category == 'speech').toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChips() {
    return Wrap(
      spacing: 8,
      children: [
        FilterChip(
          label: const Text('All'),
          selected: _selectedCategory == 'all',
          onSelected: (selected) => setState(() => _selectedCategory = 'all'),
        ),
        FilterChip(
          label: const Text('🫁 Breathing'),
          selected: _selectedCategory == 'breathing',
          onSelected: (selected) => setState(() => _selectedCategory = 'breathing'),
        ),
        FilterChip(
          label: const Text('👄 Articulation'),
          selected: _selectedCategory == 'articulation',
          onSelected: (selected) => setState(() => _selectedCategory = 'articulation'),
        ),
        FilterChip(
          label: const Text('🎵 Vocal'),
          selected: _selectedCategory == 'vocal',
          onSelected: (selected) => setState(() => _selectedCategory = 'vocal'),
        ),
        FilterChip(
          label: const Text('🗣️ Speech'),
          selected: _selectedCategory == 'speech',
          onSelected: (selected) => setState(() => _selectedCategory = 'speech'),
        ),
      ],
    );
  }

  Widget _buildCategorySection(String title, Color color, List<TrainingExercise> exercises) {
    if (exercises.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 4,
              height: 24,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...exercises.map((exercise) => _buildExerciseCard(exercise, color)).toList(),
      ],
    );
  }

  Widget _buildExerciseCard(TrainingExercise exercise, Color accentColor) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ExerciseDetailScreen(exercise: exercise),
            ),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              colors: [
                accentColor.withOpacity(0.1),
                accentColor.withOpacity(0.05),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Icon
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: accentColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  _getCategoryIcon(exercise.category),
                  color: accentColor,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              
              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      exercise.name,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.timer, size: 14, color: Colors.grey[600]),
                        const SizedBox(width: 4),
                        Text(
                          '${exercise.durationMinutes} min',
                          style: TextStyle(color: Colors.grey[600], fontSize: 12),
                        ),
                        const SizedBox(width: 12),
                        _buildDifficultyBadge(exercise.difficulty),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      exercise.description,
                      style: Theme.of(context).textTheme.bodySmall,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              
              // Arrow
              Icon(Icons.chevron_right, color: accentColor),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(duration: 300.ms).slideX(begin: -0.1, end: 0);
  }

  Widget _buildDifficultyBadge(String difficulty) {
    Color color;
    switch (difficulty) {
      case 'beginner':
        color = Colors.green;
        break;
      case 'intermediate':
        color = Colors.orange;
        break;
      case 'advanced':
        color = Colors.red;
        break;
      default:
        color = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color, width: 1),
      ),
      child: Text(
        difficulty.toUpperCase(),
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'breathing':
        return Icons.air;
      case 'articulation':
        return Icons.record_voice_over;
      case 'vocal':
        return Icons.music_note;
      case 'speech':
        return Icons.chat;
      default:
        return Icons.fitness_center;
    }
  }

  List<TrainingExercise> _getFilteredExercises() {
    var exercises = ExerciseLibrary.all;

    if (_selectedCategory != 'all') {
      exercises = exercises.where((e) => e.category == _selectedCategory).toList();
    }

    if (_selectedDifficulty != 'all') {
      exercises = exercises.where((e) => e.difficulty == _selectedDifficulty).toList();
    }

    return exercises;
  }

  void _showFilters() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Difficulty',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              children: [
                ChoiceChip(
                  label: const Text('All'),
                  selected: _selectedDifficulty == 'all',
                  onSelected: (selected) {
                    setState(() => _selectedDifficulty = 'all');
                    Navigator.pop(context);
                  },
                ),
                ChoiceChip(
                  label: const Text('Beginner'),
                  selected: _selectedDifficulty == 'beginner',
                  onSelected: (selected) {
                    setState(() => _selectedDifficulty = 'beginner');
                    Navigator.pop(context);
                  },
                ),
                ChoiceChip(
                  label: const Text('Intermediate'),
                  selected: _selectedDifficulty == 'intermediate',
                  onSelected: (selected) {
                    setState(() => _selectedDifficulty = 'intermediate');
                    Navigator.pop(context);
                  },
                ),
                ChoiceChip(
                  label: const Text('Advanced'),
                  selected: _selectedDifficulty == 'advanced',
                  onSelected: (selected) {
                    setState(() => _selectedDifficulty = 'advanced');
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
