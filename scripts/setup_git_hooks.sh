#!/bin/bash

# Script to set up git hooks for the resume management system

echo "🔧 Setting up git hooks for resume management..."

# Check if we're in a git repository
if [ ! -d ".git" ]; then
  echo "❌ Error: This script must be run from the root of the git repository"
  exit 1
fi

# Create hooks directory if it doesn't exist
mkdir -p .git/hooks

# Copy the pre-commit hook
if [ -f "git-hooks/pre-commit" ]; then
  cp git-hooks/pre-commit .git/hooks/pre-commit
  chmod +x .git/hooks/pre-commit
  echo "✅ Pre-commit hook installed and made executable"
else
  echo "❌ Error: git-hooks/pre-commit not found"
  exit 1
fi

echo "🎉 Git hooks setup complete!"
echo
echo "📝 The pre-commit hook will now automatically:"
echo "   • Detect if you made changes to the master resume"
echo "   • Build the PDF to ensure it compiles correctly"
echo "   • Prompt you for a brief description of changes"
echo "   • Create a backup and update your CHANGELOG.md"
echo "   • Bundle everything perfectly into your commit!"
echo
echo "💡 You just edit, git add, git commit, and git push. We handle the rest!"
