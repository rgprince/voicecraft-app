# 🚀 GitHub Setup & Automatic APK Building

## Why GitHub Actions?
- ✅ **Build APK in the cloud** (no need for Flutter on your laptop!)
- ✅ **Automatic builds** on every code push
- ✅ **Download ready APK** from GitHub
- ✅ **Free** for public repositories

---

## Step-by-Step Setup

### 1. Create GitHub Repository

1. Go to [GitHub.com](https://github.com/new)
2. Sign in (or create account if needed)
3. Click "New Repository" button
4. Fill in details:
   - **Repository name**: `voicecraft-app`
   - **Description**: "Beautiful voice training tracker app 🎙️"
   - **Visibility**: Public (for free Actions) or Private (if you have GitHub Pro)
   - **DO NOT** initialize with README (we already have one)
5. Click "Create repository"

### 2. Push Code to GitHub

```bash
cd /home/prince/anti/voice_craft

# Add all files
git add .

# Commit
git commit -m "Initial commit: VoiceCraft voice training app"

# Add remote (REPLACE 'your-username' with your GitHub username!)
git remote add origin https://github.com/your-username/voicecraft-app.git

# Push to GitHub
git branch -M main
git push -u origin main
```

**Note**: GitHub will ask for authentication:
- Username: your GitHub username
- Password: Use a **Personal Access Token** (not your password!)
  - Create token at: https://github.com/settings/tokens
  - Select: `repo` scope
  - Copy the token and use it as password

---

## 3. Automatic APK Building

### How It Works

Once you push code to GitHub, the **GitHub Actions** workflow automatically:

1. ✅ Sets up Flutter environment
2. ✅ Installs dependencies
3. ✅ Builds 3 APK files (for different phone types)
4. ✅ Uploads APKs as downloadable artifacts

### Where to Find Built APKs

1. Go to your repository on GitHub
2. Click "Actions" tab
3. Click on the latest workflow run
4. Scroll down to "Artifacts" section
5. Download:
   - **voicecraft-arm64-v8a.zip** ← Use this for most modern phones (64-bit)
   - **voicecraft-armeabi-v7a.zip** ← For older phones (32-bit)
   - **voicecraft-x86_64.zip** ← For Intel-based devices (rare)

### Which APK Should I Use?

**Most likely**: `voicecraft-arm64-v8a.zip` (for phones from 2017+)

To check your phone's architecture:
- Install **CPU-Z** app from Play Store
- Look at "SoC" tab → "Instruction Sets"
- If it says `arm64-v8a` → Use arm64 APK
- If it says `armeabi-v7a` → Use armeabi APK

---

## 4. Manual Trigger (Optional)

You can manually trigger a build without pushing code:

1. Go to repository → Actions tab
2. Click "Build APK" workflow
3. Click "Run workflow" button
4. Select branch (main)
5. Click "Run workflow"

The build will start immediately!

---

## 5. Install APK on Phone

### Method 1: Download on Phone
1. Open GitHub on your phone browser
2. Go to: `github.com/your-username/voicecraft-app/actions`
3. Tap latest workflow run
4. Download the ARM64 APK
5. Open downloaded file → Install

### Method 2: Download on PC, Transfer to Phone
1. Download APK from GitHub Actions on PC
2. Extract the `.zip` file
3. Connect phone via USB
4. Copy `.apk` file to phone's Downloads folder
5. On phone, open file manager → Downloads → tap APK → Install

---

## GitHub Actions Configuration

### What the Workflow Does

File: `.github/workflows/build-apk.yml`

```yaml
Triggers:
  - Every push to main/master branch
  - Every pull request
  - Manual trigger (workflow_dispatch)

Steps:
  1. Checkout code
  2. Setup Java 17
  3. Setup Flutter (stable channel)
  4. Get dependencies (flutter pub get)
  5. Run tests (optional, won't fail build)
  6. Build APK with --split-per-abi (3 separate APKs)
  7. Upload APKs as artifacts
  8. Create build info file
```

### Build Time
- **Typical duration**: 5-8 minutes
- **Cost**: FREE (GitHub provides 2000 minutes/month for free)

---

## Updating the App

When you make changes to the code:

```bash
cd /home/prince/anti/voice_craft

# Make your changes to code files...

# Stage changes
git add .

# Commit with descriptive message
git commit -m "Added new feature: breathing exercises"

# Push to GitHub (triggers automatic build!)
git push
```

GitHub Actions will automatically build a new APK!

---

## Troubleshooting

### Issue: "remote: Permission denied"
**Solution**: Use Personal Access Token instead of password
- Go to: https://github.com/settings/tokens
- Generate new token
- Use token as password when pushing

### Issue: "Build failed: Flutter not found"
**Solution**: The workflow file should handle this automatically. If it fails:
- Check `.github/workflows/build-apk.yml` exists
- Verify Flutter version in workflow (currently 3.16.0)

### Issue: "Cannot download APK"
**Solution**: 
- Wait for workflow to complete (check green checkmark)
- APKs are in "Artifacts" section at bottom of workflow run page
- Download may be a .zip file - extract it first

### Issue: "App won't install on phone"
**Solutions**:
- Enable "Install from Unknown Sources" in phone settings
- Check you downloaded the correct architecture APK
- Try the arm64-v8a version (works on most phones)

---

## Branch Protection (Optional)

For teamwork or extra safety:

1. Go to repository → Settings → Branches
2. Add rule for `main` branch
3. Check "Require status checks to pass" → Select "build"
4. Now APK must build successfully before merging!

---

## Viewing Build Logs

If build fails:

1. Go to Actions tab
2. Click failed workflow run
3. Click "build" job
4. Expand failed step to see error logs
5. Fix the issue and push again

---

## Quick Reference

| Task | Command / Action |
|------|------------------|
| **Push code** | `git add . && git commit -m "message" && git push` |
| **Download APK** | GitHub → Actions → Latest run → Artifacts |
| **Manual build** | GitHub → Actions → Build APK → Run workflow |
| **Check build status** | GitHub → Actions tab (green ✓ or red ✗) |

---

## Example Workflow

1. You edit code on laptop
2. `git add . && git commit -m "Fixed bug" && git push`
3. GitHub Actions starts building automatically
4. Wait 5-8 minutes
5. Download fresh APK from Actions → Artifacts
6. Install on phone
7. Done! 🎉

---

**No more worrying about laptop performance!** GitHub builds it for you in the cloud! 🚀
