# VoiceCraft - Voice Training Tracker App
## स्वर शिल्प - आवाज़ प्रशिक्षण ट्रैकर

A beautiful Flutter mobile app for tracking voice training practice, with support for Hindi and English songs, pitch analysis, and gamified progress tracking.

## Features

- ✅ Daily Practice Tracker with animated checkboxes
- 🎵 Song Library (31 songs: 17 Hindi + 14 English)
- 🎙️ Voice Recording & Pitch Analysis
- 📊 Beautiful Progress Charts & Analytics
- 🔥 Streak Tracking with Fire Animations
- 🎊 Confetti Celebrations
- 🫁 Guided Breathing Exercises
- 🌓 Dark/Light Themes

## Quick Setup

### Prerequisites

1. **Install Flutter SDK**:
```bash
# Download Flutter
cd ~
git clone https://github.com/flutter/flutter.git -b stable
export PATH="$PATH:`pwd`/flutter/bin"

# Add to ~/.bashrc for permanent PATH
echo 'export PATH="$PATH:$HOME/flutter/bin"' >> ~/.bashrc

# Verify installation
flutter doctor
```

2. **Accept Android Licenses** (for APK building):
```bash
flutter doctor --android-licenses
```

### Running the App

```bash
# Get dependencies
cd voice_craft
flutter pub get

# Run on connected Android device
flutter run

# Build APK
flutter build apk --release
# APK will be at: build/app/outputs/flutter-apk/app-release.apk
```

## Project Structure

```
voice_craft/
├── lib/
│   ├── main.dart
│   ├── models/          # Data models
│   ├── providers/       # Riverpod state management
│   ├── screens/         # UI screens
│   ├── widgets/         # Reusable widgets
│   └── utils/           # Constants, themes, helpers
├── assets/
│   ├── songs/           # Song data (JSON)
│   └── animations/      # Lottie animations
└── pubspec.yaml         # Dependencies
```

## Tech Stack

- **Framework**: Flutter 3.x
- **State Management**: Riverpod
- **Database**: Hive (local NoSQL)
- **Audio**: record, just_audio, pitch_detector_dart
- **Charts**: fl_chart
- **Animations**: flutter_animate, lottie, confetti

## Development Status

🚧 **In Development** - Core features being implemented

## License

MIT License - Open Source
