import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import '../utils/theme.dart';

class LearnScreen extends StatelessWidget {
  const LearnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Learn & Guides'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildGuideCard(
            context,
            'Voice Improvement Guide',
            'Complete guide for dubbing, breathing, and articulation.',
            Icons.record_voice_over,
            Colors.blue,
            _voiceGuideContent,
          ),
          const SizedBox(height: 16),
          _buildGuideCard(
            context,
            'Hindi Songs Training',
            'Learn how to use Bollywood songs for voice training.',
            Icons.music_note,
            Colors.orange,
            _hindiSongsContent,
          ),
          const SizedBox(height: 16),
          _buildGuideCard(
            context,
            'Pitch Training',
            'Master your vocal range and pitch control.',
            Icons.graphic_eq,
            Colors.purple,
            _pitchContent,
          ),
        ],
      ),
    );
  }

  Widget _buildGuideCard(
    BuildContext context,
    String title,
    String description,
    IconData icon,
    Color color,
    String content,
  ) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GuideDetailScreen(title: title, content: content),
            ),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 32),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.grey[600],
                          ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}

class GuideDetailScreen extends StatelessWidget {
  final String title;
  final String content;

  const GuideDetailScreen({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Markdown(
        data: content,
        styleSheet: MarkdownStyleSheet(
          h1: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: AppTheme.primaryColor,
                fontWeight: FontWeight.bold,
              ),
          h2: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppTheme.accentColor,
                fontWeight: FontWeight.bold,
              ),
          h3: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
          p: Theme.of(context).textTheme.bodyLarge,
          listBullet: TextStyle(color: AppTheme.primaryColor),
        ),
      ),
    );
  }
}

// Embedded Content (Truncated for brevity, but would be full content in real app)
const String _voiceGuideContent = '''
# Voice Improvement Guide for Dubbing

## 1. Understanding Your Challenge
Fast speech and lack of clarity are common issues. This guide focuses on:
- **Pacing**: Slowing down to emphasize emotion.
- **Articulation**: Clear pronunciation of every syllable.
- **Breathing**: Supporting your voice from the diaphragm.

## 2. Daily Practice Routine
### Morning (10 mins)
1. **Hydrate**: Drink warm water.
2. **Lip Trills**: 2 minutes to warm up.
3. **Breathing**: 3 minutes of Box Breathing.
4. **Humming**: 5 minutes of scales.

### Evening (15 mins)
1. **Reading**: Read a book aloud for 10 mins (slowly!).
2. **Song Practice**: Sing one Hindi song focusing on lyrics.
3. **Review**: Record yourself and listen.

## 3. Core Techniques
### The Pencil Trick
Place a pencil between your teeth and speak. This forces your tongue and lips to work harder. Remove it and speak again - you'll feel amazing clarity!

### Syllable Punching
Read a sentence punching every syllable: "I-AM-GO-ING-TO-THE-MAR-KET". This builds muscle memory for clear articulation.
''';

const String _hindiSongsContent = '''
# Hindi Songs for Voice Training

## Why Hindi Songs?
Hindi requires active use of the tongue, lips, and throat (guttural sounds). It's excellent for:
- **Dental consonants** (त, थ, द, ध)
- **Retroflex consonants** (ट, ठ, ड, ढ)
- **Aspirated sounds** (kh, gh, bh)

## Recommended Songs

### Beginner (Slow & Simple)
1. **Lag Jaa Gale**: Long sustained notes. Good for breath control.
2. **Tum Hi Ho**: Emotional depth. Good for modulation.

### Intermediate (Rhythmic)
1. **Pehla Nasha**: Gentle rhythm. Good for flow.
2. **Channa Mereya**: High emotional range.

### Advanced (Fast & Complex)
1. **Mere Saamne Wali Khidki Mein**: Fast articulation test!
2. **Breathless (Shankar Mahadevan)**: The ultimate breath control challenge.
''';

const String _pitchContent = '''
# Pitch Training Supplement

## Understanding Pitch
Pitch is how high or low your voice sounds. For dubbing, you need a flexible range.

## Exercises
1. **Sirens**: Slide from your lowest note to your highest note like a siren.
2. **Steps**: Sing "Do-Re-Mi-Fa-Sol" and back down.
3. **Octave Jumps**: Sing a low note, then the same note an octave higher.

## Tools
- **Vocal Pitch Monitor** (App): See your pitch in real-time.
- **Tuner**: Any guitar tuner app works to check if you are on key.
''';
