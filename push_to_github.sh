#!/bin/bash

# VoiceCraft - Quick Push to GitHub Script

echo "🚀 VoiceCraft GitHub Push Script"
echo "================================="
echo ""

# Check if git is initialized
if [ ! -d .git ]; then
    echo "❌ Error: Not a git repository"
    echo "Run: git init"
    exit 1
fi

# Get GitHub username
read -p "Enter your GitHub username: " USERNAME

if [ -z "$USERNAME" ]; then
    echo "❌ Username cannot be empty"
    exit 1
fi

echo ""
echo "📝 Setting up remote..."
git remote remove origin 2>/dev/null  # Remove if exists
git remote add origin "https://github.com/$USERNAME/voicecraft-app.git"

echo "✅ Remote added: https://github.com/$USERNAME/voicecraft-app.git"
echo ""
echo "🔄 Pushing to GitHub..."
echo "   (You'll be asked for username and Personal Access Token)"
echo ""

# Ensure we're on main branch
git branch -M main

# Push
git push -u origin main

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ SUCCESS! Code pushed to GitHub!"
    echo ""
    echo "Next steps:"
    echo "1. Go to: https://github.com/$USERNAME/voicecraft-app"
    echo "2. Click 'Actions' tab"
    echo "3. Wait for build to complete (~5-8 minutes)"
    echo "4. Download APK from 'Artifacts' section"
    echo ""
    echo "🎉 GitHub will automatically build your APK!"
else
    echo ""
    echo "❌ Push failed. Common issues:"
    echo ""
    echo "1. Repository doesn't exist yet:"
    echo "   → Create it at: https://github.com/new"
    echo "   → Name: voicecraft-app"
    echo ""
    echo "2. Authentication failed:"
    echo "   → Use Personal Access Token instead of password"
    echo "   → Create at: https://github.com/settings/tokens"
    echo ""
    echo "3. Remote already exists with different URL:"
    echo "   → Run: git remote remove origin"
    echo "   → Then run this script again"
fi
