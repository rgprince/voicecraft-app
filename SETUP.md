# VoiceCraft Setup & Build Guide

## 🚀 Quick Start (Step-by-Step)

### Step 1: Install Flutter SDK

```bash
# Download Flutter
cd ~
git clone https://github.com/flutter/flutter.git -b stable --depth 1

# Add to PATH (permanently)
echo 'export PATH="$PATH:$HOME/flutter/bin"' >> ~/.bashrc
source ~/.bashrc

# Verify installation
flutter --version
```

### Step 2: Install Android Dependencies

```bash
# Run Flutter doctor to see what's needed
flutter doctor

# Accept Android licenses
flutter doctor --android-licenses
# Press 'y' to accept all
```

### Step 3: Get Project Dependencies

```bash
cd /home/prince/anti/voice_craft
flutter pub get
```

### Step 4: Build & Run

**Option A: Run on Connected Android Device**
```bash
# Connect your Android phone via USB
# Enable USB Debugging on phone

# Check if device is connected
flutter devices

# Run the app
flutter run
```

**Option B: Build Release APK**
```bash
# Build release APK (recommended)
flutter build apk --release

# APK location:
# build/app/outputs/flutter-apk/app-release.apk

# Install on phone:
adb install build/app/outputs/flutter-apk/app-release.apk
```

**Option C: Build Smaller Split APK (Optimized)**
```bash
# Build split APKs (smaller file sizes)
flutter build apk --split-per-abi --release

# This creates 3 APKs (one for each architecture):
# - app-armeabi-v7a-release.apk (32-bit ARM)
# - app-arm64-v8a-release.apk (64-bit ARM - use this for most modern phones)
# - app-x86_64-release.apk (for Intel-based devices)
```

---

## 📱 Installing APK on Your Phone

### Method 1: USB Transfer
```bash
# Copy APK to Downloads folder on phone
adb push build/app/outputs/flutter-apk/app-release.apk /sdcard/Download/

# Then open file manager on phone → Downloads → app-release.apk → Install
```

### Method 2: Direct Install via ADB
```bash
adb install build/app/outputs/flutter-apk/app-release.apk
```

### Method 3: Transfer via File Manager
1. Connect phone to PC
2. Copy APK file from `build/app/outputs/flutter-apk/app-release.apk`
3. Paste to phone's Download folder
4. Use file manager on phone to install

---

## 🐛 Troubleshooting

### Issue: "Flutter not found"
**Solution:**
```bash
# Check if flutter is in PATH
echo $PATH | grep flutter

# If not found, add to bashrc again
export PATH="$PATH:$HOME/flutter/bin"
```

### Issue: "Android SDK not found"
**Solution:**
```bash
# Install Android SDK via Android Studio, OR
# Install minimal SDK:
flutter doctor --android-licenses
```

### Issue: "Gradle build failed"
**Solution:**
```bash
cd android
./gradlew clean
cd ..
flutter clean
flutter pub get
flutter build apk
```

### Issue: "No connected devices"
**Solution:**
1. Enable USB Debugging on Android phone:
   - Settings → About Phone → Tap "Build Number" 7 times
   - Settings → Developer Options → Enable "USB Debugging"
2. Connect phone via USB
3. Accept debugging prompt on phone
4. Run: `flutter devices`

---

## ✨ Features Implemented

✅ **Home Screen** with animated progress, streak tracking, weekly chart  
✅ **Daily Tracker** with satisfying animated checkboxes + confetti celebration  
✅ **Song Library** with 31 songs (17 Hindi + 14 English) organized by level  
✅ **Progress Screen** with charts and achievements  
✅ **Beautiful Material Design 3** UI with purple/amber theme  
✅ **Smooth Animations** using flutter_animate  
✅ **Dark Theme** support  

---

## 🎯 Next Steps (To Be Implemented)

These features are planned but not yet implemented:

- ⏳ Voice Recording & Pitch Analysis
- ⏳ Breathing Exercise Animated Guide
- ⏳ Hive Database Integration (for persistent storage)
- ⏳ Notifications & Reminders
- ⏳ Onboarding Flow
- ⏳ Export Progress Data

---

## 📂 Project Structure

```
voice_craft/
├── lib/
│   ├── main.dart                    # App entry point
│   ├── screens/
│   │   ├── home_screen.dart         # ✅ Home dashboard
│   │   ├── daily_tracker_screen.dart # ✅ Daily checklist
│   │   ├── song_library_screen.dart # ✅ Song library
│   │   └── progress_screen.dart     # ✅ Progress charts
│   ├── widgets/
│   │   └── animated_checkbox.dart   # ✅ Custom checkbox
│   └── utils/
│       └── theme.dart               # ✅ App theme
├── pubspec.yaml                     # Dependencies
└── README.md                        # Project info
```

---

## 🎨 Color Scheme

- **Primary**: Deep Purple (#6B46C1)
- **Accent**: Amber (#FBBF24)
- **Gradients**: Purple → Pink, Green success

---

## ⚡ Performance Tips

1. **Build in Release Mode**: `flutter build apk --release` (10x faster than debug)
2. **Use Split APKs**: Smaller file size with `--split-per-abi`
3. **Clear Cache**: Run `flutter clean` if builds are slow

---

## 🤝 Contributing

This is a personal voice training app. Feel free to fork and customize!

---

Built with ❤️ using Flutter
