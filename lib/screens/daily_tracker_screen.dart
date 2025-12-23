import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:confetti/confetti.dart';
import '../utils/theme.dart';
import '../widgets/animated_checkbox.dart';

class DailyTrackerScreen extends StatefulWidget {
  const DailyTrackerScreen({super.key});

  @override
  State<DailyTrackerScreen> createState() => _DailyTrackerScreenState();
}

class _DailyTrackerScreenState extends State<DailyTrackerScreen> {
  late ConfettiController _confettiController;
  
  // Morning routine completion state
  final Map<String, bool> morningTasks = {
    'Facial massage (2 min)': false,
    'Breathing exercises (3 min)': false,
    'Tongue twisters (10 min)': false,
    'Vocal siren (2 min)': false,
    'Song practice (3-4 min)': false,
  };
  
  // Evening routine completion state
  final Map<String, bool> eveningTasks = {
    'Reading aloud (10 min)': false,
    'Record & review (10 min)': false,
  };

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 3));
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  bool get allTasksCompleted {
    return morningTasks.values.every((v) => v) && 
           eveningTasks.values.every((v) => v);
  }

  int get totalTasks => morningTasks.length + eveningTasks.length;
  int get completedTasks =>  morningTasks.values.where((v) => v).length +
                              eveningTasks.values.where((v) => v).length;

  void _checkDayCompletion() {
    if (allTasksCompleted) {
      _confettiController.play();
      _showCompletionDialog();
    }
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('🎉 Amazing Work!'),
        content: const Text(
          'You\'ve completed all your daily practice! Your voice is getting better every day!',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Continue'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Practice'),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Date and Progress
                _buildHeader(context),
                const SizedBox(height: 24),
                
                // Morning Routine
                _buildRoutineSection(
                  context,
                  title: 'Morning Routine',
                  icon: Icons.wb_sunny,
                  iconColor: AppTheme.accentColor,
                  tasks: morningTasks,
                ),
                const SizedBox(height: 24),
                
                // Evening Routine
                _buildRoutineSection(
                  context,
                  title: 'Evening Routine',
                  icon: Icons.nightlight,
                  iconColor: Colors.indigo,
                  tasks: eveningTasks,
                ),
                const SizedBox(height: 100), // Space for FAB
              ],
            ),
          ),
          
          // Confetti
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              colors: const [
                AppTheme.primaryColor,
                AppTheme.accentColor,
                Colors.pink,
                Colors.green,
                Colors.blue,
              ],
              numberOfParticles: 50,
              gravity: 0.3,
            ),
          ),
        ],
      ),
      floatingActionButton: allTasksCompleted
          ? FloatingActionButton.extended(
              onPressed: () {
                _confettiController.play();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('🎉 Great job! All tasks completed for today!'),
                    backgroundColor: Colors.green,
                    duration: Duration(seconds: 3),
                  ),
                );
              },
              icon: const Icon(Icons.check_circle),
              label: const Text('Day Complete!'),
            ).animate().scale(duration: 300.ms, curve: Curves.easeOutBack)
          : null,
    );
  }

  Widget _buildHeader(BuildContext context) {
    final now = DateTime.now();
    final dateStr = '${_getWeekday(now.weekday)}, ${_getMonth(now.month)} ${now.day}, ${now.year}';
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              dateStr,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
            ),
            const SizedBox(height: 16),
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 100,
                  height: 100,
                  child: CircularProgressIndicator(
                    value: completedTasks / totalTasks,
                    strokeWidth: 10,
                    backgroundColor: Colors.grey[200],
                    valueColor: AlwaysStoppedAnimation<Color>(
                      completedTasks == totalTasks 
                          ? Colors.green 
                          : AppTheme.primaryColor,
                    ),
                  ),
                ),
                Column(
                  children: [
                    Text(
                      '$completedTasks/$totalTasks',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text(
                      'tasks',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.grey[600],
                          ),
                    ),
                  ],
                ),
              ],
            ).animate().scale(duration: 400.ms, curve: Curves.easeOut),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 300.ms);
  }

  Widget _buildRoutineSection(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color iconColor,
    required Map<String, bool> tasks,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: iconColor, size: 28),
            const SizedBox(width: 12),
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Column(
              children: tasks.entries.map((entry) {
                return AnimatedCheckboxTile(
                  title: entry.key,
                  value: entry.value,
                  onChanged: (value) {
                    setState(() {
                      tasks[entry.key] = value;
                      _checkDayCompletion();
                    });
                  },
                );
              }).toList(),
            ),
          ),
        ).animate().fadeIn(delay: 100.ms, duration: 300.ms).slideX(begin: -0.1, end: 0),
      ],
    );
  }

  String _getWeekday(int weekday) {
    const weekdays = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
    return weekdays[weekday - 1];
  }

  String _getMonth(int month) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
                    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return months[month - 1];
  }
}
