import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../utils/theme.dart';
import 'daily_tracker_screen.dart';
import 'song_library_screen.dart';
import 'progress_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Icon(Icons.mic, color: AppTheme.primaryColor),
            const SizedBox(width: 8),
            const Text('VoiceCraft'),
            const SizedBox(width: 4),
            Text(
              'स्वर शिल्प',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: AppTheme.accentColor,
                  ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_outline),
            onPressed: () {
              // TODO: Navigate to profile
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Today's Progress Card
            _buildTodayProgressCard(context),
            const SizedBox(height: 24),
            
            // Streak Card
            _buildStreakCard(context),
            const SizedBox(height: 24),
            
            // This Week Progress
            _buildWeekProgressCard(context),
            const SizedBox(height: 24),
            
            // Quick Actions
            Text(
              'Quick Actions',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            _buildQuickActions(context),
            const SizedBox(height: 24),
            
            // Motivational Quote
            _buildMotivationalQuote(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTodayProgressCard(BuildContext context) {
    return Card(
      child: Container(
        decoration: BoxDecoration(
          gradient: AppTheme.purplePinkGradient,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Text(
              'Today\'s Progress',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            // Circular Progress Indicator
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 120,
                  height: 120,
                  child: CircularProgressIndicator(
                    value: 0.60,
                    strokeWidth: 12,
                    backgroundColor: Colors.white.withOpacity(0.3),
                    valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
                Column(
                  children: [
                    Text(
                      '60%',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text(
                      'Complete',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.white.withOpacity(0.8),
                          ),
                    ),
                  ],
                ),
              ],
            ).animate().scale(duration: 600.ms, curve: Curves.easeOutBack),
            const SizedBox(height: 16),
            Text(
              '4 of 7 exercises completed',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.white.withOpacity(0.9),
                  ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 400.ms).slideX(begin: -0.2, end: 0);
  }

  Widget _buildStreakCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.accentColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.local_fire_department,
                color: AppTheme.accentColor,
                size: 32,
              ),
            ).animate(onPlay: (controller) => controller.repeat())
                .shimmer(duration: 2.seconds, color: AppTheme.accentColor.withOpacity(0.5)),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '7 Day Streak!',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Keep it up! You\'re on fire! 🔥',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[600],
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(delay: 100.ms, duration: 400.ms).slideX(begin: -0.2, end: 0);
  }

  Widget _buildWeekProgressCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'This Week',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildDayBar(context, 'M', 0.8, true),
                _buildDayBar(context, 'T', 0.9, true),
                _buildDayBar(context, 'W', 0.7, true),
                _buildDayBar(context, 'T', 1.0, true),
                _buildDayBar(context, 'F', 0.6, true),
                _buildDayBar(context, 'S', 0.0, false),
                _buildDayBar(context, 'S', 0.0, false),
              ],
            ),
          ],
        ),
      ),
    ).animate().fadeIn(delay: 200.ms, duration: 400.ms).slideX(begin: -0.2, end: 0);
  }

  Widget _buildDayBar(BuildContext context, String day, double progress, bool completed) {
    return Column(
      children: [
        Container(
          width: 32,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: 32,
              height: 100 * progress,
              decoration: BoxDecoration(
                gradient: completed ? AppTheme.successGradient : null,
                color: completed ? null : Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
              ),
            ).animate().scaleY(
                  begin: 0,
                  end: 1,
                  duration: 600.ms,
                  delay: Duration(milliseconds: 100 * day.hashCode % 500),
                  curve: Curves.easeOutBack,
                ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          day,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: completed ? AppTheme.primaryColor : Colors.grey,
              ),
        ),
      ],
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildActionButton(
                context,
                icon: Icons.wb_sunny,
                label: 'Start Morning',
                gradient: AppTheme.purplePinkGradient,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const DailyTrackerScreen()),
                  );
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildActionButton(
                context,
                icon: Icons.music_note,
                label: 'Songs',
                gradient: const LinearGradient(
                  colors: [Color(0xFFF59E0B), Color(0xFFFBBF24)],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SongLibraryScreen()),
                  );
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildActionButton(
                context,
                icon: Icons.mic,
                label: 'Record',
                gradient: const LinearGradient(
                  colors: [Color(0xFFEF4444), Color(0xFFF87171)],
                ),
                onTap: () {
                  // TODO: Navigate to recording
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildActionButton(
                context,
                icon: Icons.bar_chart,
                label: 'Stats',
                gradient: const LinearGradient(
                  colors: [Color(0xFF3B82F6), Color(0xFF60A5FA)],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ProgressScreen()),
                  );
                },
              ),
            ),
          ],
        ),
      ],
    ).animate().fadeIn(delay: 300.ms, duration: 400.ms);
  }

  Widget _buildActionButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Gradient gradient,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.white, size: 32),
            const SizedBox(height: 8),
            Text(
              label,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMotivationalQuote(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.accentColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.accentColor.withOpacity(0.3),
          width: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.format_quote, color: AppTheme.accentColor),
              const SizedBox(width: 8),
              Text(
                'Daily Inspiration',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: AppTheme.accentColor,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'The voice is an instrument that requires daily care and practice. Keep training, keep improving!',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontStyle: FontStyle.italic,
                ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 400.ms, duration: 400.ms);
  }
}
