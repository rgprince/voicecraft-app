import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'utils/theme.dart';
import 'screens/home_screen.dart';
import 'models/practice_record.dart';
import 'models/user_settings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Hive
  await Hive.initFlutter();
  
  // Register adapters
  Hive.registerAdapter(PracticeRecordAdapter());
  Hive.registerAdapter(UserSettingsAdapter());
  
  // Open boxes
  await Hive.openBox<PracticeRecord>('practice_records');
  await Hive.openBox<UserSettings>('user_settings');
  
  // Initialize demo data if first run
  final settingsBox = Hive.box<UserSettings>('user_settings');
  if (settingsBox.isEmpty) {
    await settingsBox.put('settings', UserSettings());
  }
  
  runApp(
    const ProviderScope(
      child: VoiceCraftApp(),
    ),
  );
}

class VoiceCraftApp extends ConsumerWidget {
  const VoiceCraftApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'VoiceCraft',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const HomeScreen(),
    );
  }
}
