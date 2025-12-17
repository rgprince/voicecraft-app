import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/theme.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // App Logo
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: AppTheme.purplePinkGradient,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.primaryColor.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: const Icon(Icons.mic, color: Colors.white, size: 64),
            ),
            const SizedBox(height: 24),
            
            // App Name
            Text(
              'VoiceCraft',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryColor,
              ),
            ),
            Text(
              'स्वर शिल्प',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppTheme.accentColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Version 1.0.0',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 32),
            
            // About App
            _buildSection(
              context,
              'About the App',
              'VoiceCraft is your personal voice training companion designed for aspiring dubbing artists and anyone looking to improve their speech. Practice breathing exercises, articulation drills, and learn with curated songs!',
              Icons.info_outline,
            ),
            const SizedBox(height: 20),
            
            // Developer Section
            _buildSection(
              context,
              'Developer',
              'Created with ❤️ by Prince\n\nPassionate about AI, mobile apps, and creating tools that help people grow.',
              Icons.person_outline,
            ),
            const SizedBox(height: 24),
            
            // Links
            Text(
              'Check Out More Projects',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            
            _buildLinkButton(
              context,
              'My Website',
              'Other apps, Mini LLM & more',
              Icons.language,
              'https://its-rg.netlify.app',
            ),
            const SizedBox(height: 12),
            _buildLinkButton(
              context,
              'GitHub',
              'Source code & projects',
              Icons.code,
              'https://github.com/rgprince',
            ),
            const SizedBox(height: 12),
            _buildLinkButton(
              context,
              'Support Me',
              'Help me create more apps!',
              Icons.favorite_outline,
              'https://its-rg.netlify.app/support',
            ),
            const SizedBox(height: 32),
            
            // Footer
            Text(
              'Thank you for using VoiceCraft',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, String content, IconData icon) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: AppTheme.primaryColor, size: 20),
              const SizedBox(width: 8),
              Text(
                title,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildLinkButton(BuildContext context, String title, String subtitle, IconData icon, String url) {
    return Card(
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppTheme.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: AppTheme.primaryColor),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
        trailing: const Icon(Icons.open_in_new, size: 18),
        onTap: () => _launchUrl(url),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
