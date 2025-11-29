import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../utils/theme.dart';

class SongLibraryScreen extends StatefulWidget {
  const SongLibraryScreen({super.key});

  @override
  State<SongLibraryScreen> createState() => _SongLibraryScreenState();
}

class _SongLibraryScreenState extends State<SongLibraryScreen> 
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Song Library'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Hindi 🇮🇳', icon: Icon(Icons.music_note)),
            Tab(text: 'English 🇬🇧', icon: Icon(Icons.music_note)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildSongList(_hindiSongs, 'hindi'),
          _buildSongList(_englishSongs, 'english'),
        ],
      ),
    );
  }

  Widget _buildSongList(List<Map<String, dynamic>> songs, String language) {
    // Group songs by level
    final beginner = songs.where((s) => s['level'] == 'Beginner').toList();
    final intermediate = songs.where((s) => s['level'] == 'Intermediate').toList();
    final advanced = songs.where((s) => s['level'] == 'Advanced').toList();
    final expert = songs.where((s) => s['level'] == 'Expert').toList();

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        if (beginner.isNotEmpty) _buildLevelSection('Beginner', beginner, Colors.green),
        if (intermediate.isNotEmpty) _buildLevelSection('Intermediate', intermediate, Colors.orange),
        if (advanced.isNotEmpty) _buildLevelSection('Advanced', advanced, Colors.red),
        if (expert.isNotEmpty) _buildLevelSection('Expert', expert, Colors.purple),
      ],
    );
  }

  Widget _buildLevelSection(String level, List<Map<String, dynamic>> songs, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
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
                level,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
              ),
            ],
          ),
        ),
        ...songs.map((song) => _buildSongCard(song, color)).toList(),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildSongCard(Map<String, dynamic> song, Color levelColor) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () {
          _showSongDetails(song);
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.music_note, color: levelColor, size: 28),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (song['titleHindi'] != null) ...[
                          Text(
                            song['titleHindi'],
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 2),
                        ],
                        Text(
                          song['title'],
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                color: Colors.grey[600],
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  _buildInfoChip(Icons.movie, song['film']),
                  const SizedBox(width: 8),
                  _buildInfoChip(Icons.timer, '${song['bpm']} BPM'),
                ],
              ),
              if (song['singer'] != null) ...[
                const SizedBox(height: 8),
                Text(
                  'Singer: ${song['singer']}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey[600],
                      ),
                ),
              ],
            ],
          ),
        ),
      ),
    ).animate().fadeIn(duration: 300.ms).slideX(begin: -0.1, end: 0);
  }

  Widget _buildInfoChip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: Colors.grey[700]),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[700],
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  void _showSongDetails(Map<String, dynamic> song) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        expand: false,
        builder: (context, scrollController) {
          return SingleChildScrollView(
            controller: scrollController,
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                if (song['titleHindi'] != null) ...[
                  Text(
                    song['titleHindi'],
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 4),
                ],
                Text(
                  song['title'],
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.grey[600],
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Film: ${song['film']} • ${song['bpm']} BPM',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 24),
                
                // Practice Tips
                _buildDetailSection(
                  'Practice Tips',
                  song['tips'] ?? 'Focus on clear pronunciation and breath control.',
                ),
                
                const SizedBox(height: 80),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildDetailSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          content,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  // HINDI SONGS DATA
  final List<Map<String, dynamic>> _hindiSongs = [
    // Level 1 - Beginner
    {
      'title': 'Lag Jaa Gale',
      'titleHindi': 'लग जा गले',
      'film': 'Woh Kaun Thi?',
      'singer': 'Lata Mangeshkar',
      'bpm': 65,
      'level': 'Beginner',
      'tips': 'Perfect for slow, emotional delivery. Focus on breath control.',
    },
    {
      'title': 'Tum Hi Ho',
      'titleHindi': 'तुम ही हो',
      'film': 'Aashiqui 2',
      'singer': 'Arijit Singh',
      'bpm': 76,
      'level': 'Beginner',
      'tips': 'Excellent for practicing sustained notes and emotional expression.',
    },
    {
      'title': 'Pani Da Rang',
      'titleHindi': 'पानी दा रंग',
      'film': 'Vicky Donor',
      'singer': 'Ayushmann Khurrana',
      'bpm': 85,
      'level': 'Beginner',
      'tips': 'Simple, catchy melody. Great for building confidence.',
    },
    
    // Level 2 - Intermediate
    {
      'title': 'Pehla Nasha',
      'titleHindi': 'पहला नशा',
      'film': 'Jo Jeeta Wohi Sikandar',
      'singer': 'Udit Narayan',
      'bpm': 105,
      'level': 'Intermediate',
      'tips': 'Practice gentle rhythm and emotional build-up.',
    },
    {
      'title': 'Channa Mereya',
      'titleHindi': 'छन्ना मेरेया',
      'film': 'Ae Dil Hai Mushkil',
      'singer': 'Arijit Singh',
      'bpm': 90,
      'level': 'Intermediate',
      'tips': 'Balance soft singing with emotional intensity.',
    },
    {
      'title': 'Jeena Jeena',
      'titleHindi': 'जीना जीना',
      'film': 'Badlapur',
      'singer': 'Atif Aslam',
      'bpm': 75,
      'level': 'Intermediate',
      'tips': 'Focus on smooth note transitions and breath control.',
    },
    
    // Level 3 - Advanced
    {
      'title': 'Mere Saamne Wali Khidki Mein',
      'titleHindi': 'मेरे सामने वाली खिड़की में',
      'film': 'Padosan',
      'singer': 'Kishore Kumar',
      'bpm': 140,
      'level': 'Advanced',
      'tips': 'Ultimate test of fast articulation! Start at 70% tempo.',
    },
    {
      'title': 'Gulabi Aankhen',
      'titleHindi': 'गुलाबी आँखें',
      'film': 'The Train',
      'singer': 'Mohammed Rafi',
      'bpm': 120,
      'level': 'Advanced',
      'tips': 'High-energy with repetitive phrases. Focus on rhythmic delivery.',
    },
  ];

  // ENGLISH SONGS DATA
  final List<Map<String, dynamic>> _englishSongs = [
    // Level 1 - Beginner
    {
      'title': 'Twinkle Twinkle Little Star',
      'film': 'Traditional',
      'singer': 'Various',
      'bpm': 75,
      'level': 'Beginner',
      'tips': 'Classic for practicing clear vowels and slow pace.',
    },
    {
      'title': 'Happy Birthday',
      'film': 'Traditional',
      'singer': 'Various',
      'bpm': 120,
      'level': 'Beginner',
      'tips': 'Everyone knows it! Practice hitting each note clearly.',
    },
    
    // Level 2 - Intermediate
    {
      'title': 'Somewhere Over the Rainbow',
      'film': 'The Wizard of Oz',
      'singer': 'Judy Garland',
      'bpm': 90,
      'level': 'Intermediate',
      'tips': 'Beautiful vowels and wide range. Practice smooth transitions.',
    },
    {
      'title': 'Let It Be',
      'film': 'Let It Be',
      'singer': 'The Beatles',
      'bpm': 140,
      'level': 'Intermediate',
      'tips': 'Moderate pace with emotional control. Clear enunciation.',
    },
    {
      'title': 'Imagine',
      'film': 'Imagine',
      'singer': 'John Lennon',
      'bpm': 76,
      'level': 'Intermediate',
      'tips': 'Slow and deliberate. Focus on soft consonants.',
    },
    
    // Level 3 - Advanced
    {
      'title': 'Supercalifragilisticexpialidocious',
      'film': 'Mary Poppins',
      'singer': 'Julie Andrews',
      'bpm': 138,
      'level': 'Advanced',
      'tips': 'Ultimate articulation challenge! Start at 50% tempo.',
    },
  ];
}
